"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'                "目录树
    Plug 'vimwiki/vimwiki'                   
    Plug 'Lokaltog/vim-powerline'            "状态栏增强
    Plug 'vim-airline/vim-airline'            "状态列增强
"    Plug 'vim-airline/vim-airline-themes'            "状态列增强
    Plug 'tpope/vim-surround'
    Plug 'ctrlpvim/ctrlp.vim'                "模糊搜索
    Plug 'junegunn/goyo.vim'                "简化阅读
    Plug 'terryma/vim-multiple-cursors'            "V增强
    Plug 'jreybert/vimagit'
    Plug 'vim-syntastic/syntastic'            "语法检查
    Plug 'Yggdroot/indentLine'            "缩进线
"    Plug 'davidhalter/jedi-vim'                "python不全
"WEB
    Plug 'mattn/emmet-vim'                "html不全
    Plug 'hail2u/vim-css3-syntax'            "css高亮
    Plug 'Raimondi/delimitMate'                "前后括制对齐
    "Plug 'pangloss/vim-javascript'            "java高亮
"them
    Plug 'morhetz/gruvbox'
"补全
"    Plug 'ycm-core/YouCompleteMe'        "多线项补全
    Plug 'SirVer/ultisnips'                "PYTHON补全
    Plug 'honza/vim-snippets'
call plug#end()

"----------------------------------------------------\
"------------------------vim--------------------------|
"----------------------------------------------------/

"文件代码形式utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr


"提示乱码
"language messages zh_CN.utf-8


"vim list debug ifx
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim


"turn bakcup off, since most stuff is in SVN, etc.aanyway
set nowritebackup
set noswapfile
set nobackup

set autoread        "外部检测auto
set nocompatible            "KILL-VI一致性
" 折叠
set foldenable            "允许折叠
set fdm=syntax            " 按语法折叠
set fdm=manual            "手动


set novisualbell            "no闪烁
set number                    "行号
"set relativenumber            "相对行号
set laststatus=2            "显示状态行
set ruler            "总是显示下行数
set showcmd                "显示输入命令

"语法高亮
syntax enable
syntax on

"进退x**
set tabstop=4
set softtabstop=4
set backspace=2

filetype indent on            "自适应语言的智能缩进

set autoindent
set cursorline

set hlsearch
set incsearch
set ignorecase
set showmatch

set smartindent
set cindent

"代码折叠
set foldenable
set nowrap            "禁止折行
"折叠方法
"manual        手工折叠
"indent        缩进表示
"expr        表达式折叠
"syntax        语法定义折叠
"diff        没有更改的文本折叠
"maraker    标记折叠，默认：{{{和}}}
set foldmethod=syntax
"在左侧显示
set foldcolumn=4

"7行上下滚动始终在中间
set so=7


"重载保存文件
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')

"智能当前行高亮
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertLeave,WinEnter * set nocursorline

"关键字补全
set complete-=i                "disable scanning included files
set complete-=t                "disable searching tags

"colorscheme desert
syntax on
set t_Co=256
"colorscheme jellybeans
"if has("termguicolors")
"        "fix bug for vim"
"        set t_8f=[38;2;%lu;%lu;%lum
"        set t_8b=[48;2;%lu;%lu;%lum
"
"        "enable true color
"        set termguicolors
"----------------插件
"endif



"------------------------------------------------------\
"--------------------vim-plug---------------------------|
"------------------------------------------------------/

"Nerdtree==================
"启动时自动打开
"autocmd vimenter * NERDTree       

"打开一个目录同时TREE打开，关闭文件时TREE自动关闭
autocmd StdinReadPre * let s:std_in=1
autocmd vimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"打开的同时链接其历史记录(open tree automatically when vim starts up on
"opening a directory)
autocmd StdinReadPre * let s:std_in=1
autocmd vimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

"close vim if the only windows left open is a nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"F2启动/关闭
map <F2> :NERDTreeToggle<CR>   

"wiki============================
set nocompatible
    filetype plugin on
    syntax on

"goyo=============================
":Goyo            "toggle Goyo
":Goyo[demension]
":Goyo!            "off
let	go:goyo_margin_top = 2
let	go:goyo_margin_bottom = 2

"indentline=======================
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"jedi============================
let g:jedi#auto_initialization = 1
autocmd FileType python setlocal omnifunc=jedi#completions

"javascript-highlight=================
let javascript_enable_domhtmlcss = 1

"PowerLine======================
let g:Powerline_colorscheme='solarzed256'

"airline======================
let g:airline#extensions#tabline#enabled    =    1
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_theme='zenburn'                    "'behelit''zenburn'

"emmet-html&css->deful        (C=ctrl-)=====================
let g:user_emmet_leader_key='C-y'
autocmd filetype *html* imap <c-_> <c-y>/
autocmd filetype *html* map <c-_> <c-y>/

"ultisnips==============================
let g:UltiSnipsUsePythonVersion =2
let g:UltiSnipsExpandTrigger    ="<c-tab>"
let g:UltiSnipsListSnippets        ="<c-l>"
let g:UltiSnipsJumpForwardTrigger    =    "<c-j>"
let g:UltiSnipsJumpBackwardTrigger    =    "<c-k>"

"syntastic====================
let g:syntastic_java_javac_classpath=$CLASS_PATH
