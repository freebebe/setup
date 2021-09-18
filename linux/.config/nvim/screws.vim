"_______________________________________________________________________________
"                                                                        lspsaga

nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

"_______________________________________________________________________________
"                                                                          emmet
" let g:user_emmet_leader_key='C-y'
" autocmd filetype *html* imap <c-_> <c-y>/
" autocmd filetype *html* map <c-_> <c-y>/
"
let g:user_emmet_expandabbr_key = '<F2>'
let g:user_emmet_leader_key= '<C-e>'

"_______________________________________________________________________________
"                                                               operator-surround
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

"_______________________________________________________________________________
"                                                                           def
"
" nnoremap <silent> :<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap tN :tabnew<CRlq
            \ -columns=indent:mark:icon:icons:filename:git:size
            \ -buffer-name=tab`tabpagenr()`
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap vs :vs<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap sp :sp<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap <silent>sf :<C-u>Defx -listed -resume
            \ -columns=indent:mark:icon:icons:filename:git:size
            \ -buffer-name=tab`tabpagenr()`
            \ `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap <silent>fi :<C-u>Defx -new 
            \ -columns=indent:mark:icon:icons:filename:git:size
            \`expand('%:p:h')` -search=`expand('%:p')`<CR>

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

"_______________________________________________________________________________
""                                                                      telescope
nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

"_______________________________________________________________________________
"                                                                       neosnippet
"

" imap <expr><C-l>  <Plug>(deoppet_expand)
" imap <C-l>  <Plug>(deoppet_jump_forward)
" imap <C-y>  <Plug>(deoppet_jump_backward)
" smap <C-l>  <Plug>(deoppet_jump_forward)
" smap <C-y>  <Plug>(deoppet_jump_backward)
" imap <C-l>     <Plug>(neosnippet_expand_or_jump)
" smap <C-l>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-l>     <Plug>(neosnippet_expand_target)
" imap <C-l>  <Plug>(deoppet_expand)
" imap <C-l>  <Plug>(deoppet_jump_forward)
" smap <C-l>  <Plug>(deoppet_jump_forward)

"_______________________________________________________________________________
"                                                                   snippts.nvim
" inoremap <C-l> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
"
" inoremap <C-l> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

