"配置同步
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"======================十字定位线
set colorcolumn=80          "警示線
set nofixendofline
set cursorcolumn
set cursorline

  "colo
  " highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

  " highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

  augroup BgHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
  augroup END

  if &term =~ "screen"
    autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
    autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
  endif

"=========================重载保存文件
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')

" stop loading config if it's on tiny or small太小停滞加载
if !1 | finish | endif

" incremental substitution 增值替代 (neovim)
if has('nvim')
  set inccommand=split
endif

" Turn off paste mode when leaving insert离开状态关闭粘贴
autocmd InsertLeave * set nopaste

">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>For conceal markers.对隐藏标记
" if has('conceal')
  " set conceallevel=2 concealcursor=niv
" endif

" Add asterisks in block comments 块标记*号
set formatoptions+=r

"=========================Highlight all instances of word under cursor, when idle.
                          " http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
                          " Useful when studying strange source code.
                          " Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=300
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"======!!!error!!========" Clean all useless whitespace清理所有无用空白
" autocmd BufWritePre *
  " \ if !exists('g:skip_clean_whitespace') && !exists('b:skip_clean_whitespace')|
  " \   call lib#WithSavedState('%s/\s\+$//e')|
  " \ endif

"========================" Speed up transition from modes
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd InsertEnter * set timeoutlen=0
    autocmd InsertLeave * set timeoutlen=1000
  augroup END
endif
