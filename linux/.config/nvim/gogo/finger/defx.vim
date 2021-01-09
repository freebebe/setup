" fi = tree open
" sf = tree
"    > h = backspace
"    > enter = open
" Define mappings
"cnoreabbrev sf Defx -listed -new
"      \ -columns=indent:mark:icon:icons:filename:git:size
"      \ -buffer-name=tab`tabpagenr()`<CR>
" call defx#custom#option('_',{
      " \ 'split'     : 'vertical',
      " \ 'winwidth'  : 30,
      " \ 'show_ignored_files': 0,
      " \ 'buffer_name': '',
      " \ 'toggle': 1,
      " \ 'resume': 1,
      " \ 'ignored_files': '*.pyc,*.pyd,*~,*.swo,*.swp,.git,.hg,.svn,.bzr,.DS_Store',
      " \ })

nnoremap <silent>sf :<C-u>Defx -listed -resume
      \ -columns=indent:mark:icon:icons:filename:git:size
      \ -buffer-name=tab`tabpagenr()`
      \ `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap <silent>fi :<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> c
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> p
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('open')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> P
	  \ defx#do_action('open', 'pedit')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_or_close_tree')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> d
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
	endfunction

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

function! DefxSmartL(_)
    if defx#is_directory()
        call defx#call_action('open_tree')
        normal! j
    else
        let filepath = defx#get_candidate()['action__path']
        if tabpagewinnr(tabpagenr(), '$') >= 3        " if there are more than 2 normal windows
            if exists(':ChooseWin') == 2
                ChooseWin
            else

                if input ==# 'n' | return | endif
                if input == winnr() | return | endif
                exec input . 'wincmd w'
            endif
            exec 'e' filepath
        else
            exec 'wincmd w'
            exec 'e' filepath
        endif
    endif
endfunction

function! DefxSmartH(_)
    " if cursor line is first line, or in empty dir
    if line('.') ==# 1 || line('$') ==# 1
        return defx#call_action('cd', ['..'])
    endif

    " candidate is opend tree?
    if defx#is_opened_tree()
        return defx#call_action('close_tree')
    endif

    " parent is root?
    let s:candidate = defx#get_candidate()
    let s:parent = fnamemodify(s:candidate['action__path'], s:candidate['is_directory'] ? ':p:h:h' : ':p:h')
    let sep = s:SYS.isWindows ? '\\' :  '/'
    if s:trim_right(s:parent, sep) == s:trim_right(b:defx.paths[0], sep)
        return defx#call_action('cd', ['..'])
    endif

    " move to parent.
    call defx#call_action('search', s:parent)

    " if you want close_tree immediately, enable below line.
    call defx#call_action('close_tree')
endfunction

function! DefxYarkPath(_) abort
    let candidate = defx#get_candidate()
    let @+ = candidate['action__path']
    echo 'yarked: ' . @+
endfunction

function! s:trim_right(str, trim)
    return substitute(a:str, printf('%s$', a:trim), '', 'g')
endfunction

autocmd BufEnter * if (!has('vim_starting') && winnr('$') == 1 && &filetype ==# 'defx') | quit | endif
" autocmd VimEnter * call s:welcome()
" " autocmd FileType startify :Defx
function s:welcome()
    if s:vim_plug_installing
        return
    endif
    if argc()
        return
    endif
    if exists(':Startify') == 2
        Startify
        if isdirectory(bufname(1))
            bwipeout! 1
        endif
    endif
    if exists(':VimFiler') == 2
        VimFiler
        wincmd p
    elseif exists(':Defx') == 2
        Defx
        wincmd p
    endif
endfunction

autocmd FileType defx call s:defx_init()
function! s:defx_init()
    setl nonumber
    setl norelativenumber
    setl listchars=
    setl nofoldenable
    setl foldmethod=manual
endfunction

