" filetype off
filetype plugin on
set shell=zsh
set t_Co=256
" Z4-bit color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

"配置同步
autocmd BufWritePost $MYVIMRC source $MYVIMRC

"文件代码形式utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr
"文件格式
set matchpairs=(:),[:],{:}
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md,.rb,.tsx,.ts,.jpg,.jpeg,.gif,.png,.vim
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

    " JavaScript
    au BufNewFile,BufRead *.es6 setf javascript
    " TypeScript
    au BufNewFile,BufRead *.tsx setf typescript
    " Markdown
    " au BufNewFile,BufRead *.md set filetype=markdown
    " Flow
    au BufNewFile,BufRead *.flow set filetype=javascript

"格式
"inside_be_wiki-PLUG   |  set nocompatible            "设置不兼容
set smarttab                "Use 'shiftwidth' when using <Tab> in front of a line. By default it's used only for shift commands (<, >).
set smartindent             "smart when using tabs
set autoindent
set expandtab
set history=10000
set linebreak               "自动换行
set vb t_vb=                "消警告提声
set laststatus=2            "显示状态行
set ruler                   "总是显示下行数
set showcmd                 "显示输入命令
set title                   "设置顶题
set titlelen=95             "顶标间距
set nobackup                "不备份
    set nowritebackup
    set noswapfile

set complete-=i             "disable scanning included files
set complete-=t             "disable searching tags

set hlsearch                "Enable search highlighting.
set incsearch
set ignorecase              "搜索忽略大小写
set showmatch

set cindent
set so=7                    "7行上下滚动始终在中间

set virtualedit=block       "eab virtualedit in block mode

set cmdheight=2
set cmdwinheight=50

set emoji
" Disable modeline.
" set modelines=0
" set nomodeline
" autocmd MyAutoCmd BufRead, BufWritePost *.txt setlocal modelines=5 modeline

set updatetime=100          "异步时间



"缩进
filetype indent on          "自适应语言的智能缩进
set shiftwidth=4
" set tabstop=2

"=========================smart indent
set ai                      "Auto indent
set si                      "Smart indent
    set autoindent smartindent

    function! GnuIndent()
        setlocal cinptions=4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
        setlocal shiftwidth=2
        setlocal tabstop=8
        setlocal noexpandtab
    endfunction

set backspace=start,eol,indent
set number                  "行号
set relativenumber          "递进行号

"=========================进退x***
set tabstop=4     " requiet->:180
set softtabstop=4
set backspace=2

"=========================语法高亮-字典
syntax enable
syntax on
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertLeave,WinEnter * set nocursorline
au BufNewFile,BufRead *.ejs set filetype=html

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

"=========================代码折叠
set foldenable
set nowrap                  "禁止折行
" set nofoldenable			"启动vim时关闭折叠代码
set foldmethod=manual       "z-f = all packup
    "manual        手工折叠
    "indent        缩进表示
    "expr        表达式折叠
    "syntax        语法定义折叠
    "diff        没有更改的文本折叠
    "maraker    标记折叠，默认：{{{和}}}

    "Show folding level
    if has('neovim')
        set foldcolumn=auto:1
    else
        set foldcolumn=1
    endif
    set fillchars=vert:\|
    set commentstring=%s

    if exists('*FoldCCtext')
        " use FoldCCtext
        set foldtext=FoldCCtext()
    endif

"=========================重载保存文件
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')

" stop loading config if it's on tiny or small太小停滞加载
if !1 | finish | endif

" incremental substitution 增值替代 (neovim)
if has('neovim')
    set inccommand=split
endif

" Turn off paste mode when leaving insert离开状态关闭粘贴
autocmd InsertLeave * set nopaste

">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>For conceal markers.对隐藏标记
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
autocmd BufWritePre *
    \ if !exists('g:skip_clean_whitespace') && !exists('b:skip_clean_whitespace')|
    \   call lib#WithSavedState('%s/\s\+$//e')|
    \ endif

"========================" Speed up transition from modes
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif
