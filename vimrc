"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'                "目录树
	Plug 'preservim/nerdcommenter'				"注释
    Plug 'vimwiki/vimwiki'                   
	Plug 'itchyny/lightline.vim'			"状态
    Plug 'tpope/vim-surround'       "hello world! >>>>> [hello] world!
    Plug 'ctrlpvim/ctrlp.vim'                "模糊搜索
    Plug 'junegunn/goyo.vim'                "简化阅读
    Plug 'terryma/vim-multiple-cursors'            "V增强
    "Plug 'jreybert/vimagit'
    Plug 'vim-syntastic/syntastic'            "语法检查
    Plug 'Yggdroot/indentLine'            "缩进线
"	Plug 'aklt/plantuml-syntax'				"mind map
	Plug 'terryma/vim-multiple-cursors'			"批量修改
"WEB
    Plug 'hail2u/vim-css3-syntax'            "css高亮
    Plug 'Raimondi/delimitMate'                "前后括制对齐
    Plug 'pangloss/vim-javascript'            "java高亮
    Plug 'turbio/bracey.vim'				"h+c+j 补全
	Plug 'ap/vim-css-color'			"css-color
    " Plug 'suan/vim-instant-markdown'        "markdown
"补全
     Plug 'ycm-core/YouCompleteMe'
     Plug 'mattn/emmet-vim'
"    Plug 'SirVer/ultisnips'                "PYTHON补全
    " Plug 'honza/vim-snippets'
"    Plug 'davidhalter/jedi-vim'                "python不全
"scheme
    Plug 'cormacrelf/vim-colors-github'
    Plug 'cocopon/iceberg.vim'
call plug#end()

"----------------------------------------------------\
"------------------------vim--------------------------|
"----------------------------------------------------/

"配置同步
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"网页同步
nnoremap ,v :exec '!exec firefox %'<CR>

"=========================文件代码形式utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr


"=========================提示乱码
"language messages zh_CN.utf-8


"=========================vim list debug ifx
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim


"turn bakcup off, since most stuff is in SVN, etc.aanyway
set nowritebackup
set noswapfile
set nobackup

set autoread        "外部检测auto
set nocompatible            "KILL-VI一致性
set wildmenu            

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p

"========================= 折叠
set foldenable            "允许折叠
set fdm=syntax            " 按语法折叠
set fdm=manual            "手动


set novisualbell            "no闪烁
set vb t_vb=                 "消警告提声
set number                    "行号

"=========================set relativenumber            "相对行号
set laststatus=2            "显示状态行
set ruler            "总是显示下行数
set showcmd                "显示输入命令

"=========================语法高亮
syntax enable
syntax on

"=========================进退x**
set tabstop=4
set softtabstop=4
set backspace=2
set expandtab

filetype indent on            "自适应语言的智能缩进

set autoindent
set cursorline

set hlsearch
set incsearch
set ignorecase
set showmatch

set smartindent
set cindent

"======================十字定位线
set cursorline
set cursorcolumn

"=========================代码折叠
set foldenable
set nowrap            "禁止折行
" set fooldmethod=indent
" set fooldmethod=syntax		"基于缩进或语法进行代码折叠
set nofoldenable			"启动vim时关闭折叠代码
"=========================折叠方法
"manual        手工折叠
"indent        缩进表示
"expr        表达式折叠
"syntax        语法定义折叠
"diff        没有更改的文本折叠
"maraker    标记折叠，默认：{{{和}}}
set foldmethod=syntax
"=========================在左侧显示
set foldcolumn=4

"=========================7行上下滚动始终在中间
set so=7


"=========================重载保存文件
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')

"=========================智能当前行高亮
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertLeave,WinEnter * set nocursorline

"=========================关键字补全
set complete-=i                "disable scanning included files
set complete-=t                "disable searching tags

"=========================改键
imap ,, <ESC>la
imap <TAB> <C-N>
imap <S-TAB> <C-P> 

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
"endif

"配色
        " colorscheme iceberg
                 " let g:lightline = {'colorscheme': 'iceberg'}
        colorscheme github
                let g:lightline = {'colorscheme': 'github'}
                let g:github_colors_soft = 1               "background
         " set background=light
        " colorscheme two-firewatch
    


"------------------------------------------------------\
"--------------------vim-plug---------------------------|
"------------------------------------------------------/

"================Nerdtree==================
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

"位设
let g:NERDTreeWinPos='right'

"行号
let g:NERDTreeShowLineNumbers=1
"================nerdcommenter=============================
let g:NERDSpaceDelims = 1			"空格
let g:NERDCompactSexyComs = 1		"简约
let g:NERDCommentEmptyLines = 1		"倒~空
let g:NERDTrimTrailingWhitespace = 1	"收尾
"let g:NERDToggleCheckAllLines = 1	"chack
"learder=\
"\-c-space 正反注释

"================wiki============================
set nocompatible
    filetype plugin on
    syntax on

"================goyo=============================
" :Goyo            "toggle Goyo
" :Goyo[demension]
" :Goyo!            "off
" let	go:goyo_margin_top = 2
" let	go:goyo_margin_bottom = 2

"================indentline=======================
let g:indentLine_char_list = ['|', '¦', '┆', '┊']"

"================jedi============================
let g:jedi#auto_initialization = 1
autocmd FileType python setlocal omnifunc=jedi#completions

"================javascript-highlight=================
let javascript_enable_domhtmlcss = 1

"================PowerLine======================
let g:Powerline_colorscheme='solarzed256'


"================emmet-html&css->deful        (C=ctrl-)=====================
" let g:user_emmet_leader_key='C-y'
" autocmd filetype *html* imap <c-_> <c-y>/
" autocmd filetype *html* map <c-_> <c-y>/

"================ultisnips==============================
let g:UltiSnipsUsePythonVersion =2
let g:UltiSnipsExpandTrigger    ="<c-tab>"
let g:UltiSnipsListSnippets          ="<c-l>"
let g:UltiSnipsJumpForwardTrigger    =    "<c-j>"
let g:UltiSnipsJumpBackwardTrigger   =    "<c-k>"

"================syntastic====================
let g:syntastic_java_javac_classpath=$CLASS_PATH

"================emmet================
"map <F3> <C-\>
let g:user_emmet_leader_key='<C-\>'

"===============YCM=====================
let g:ycm_clangd_binary_path = "~/Progm-plug/clang+llvm"
" YCM 补全菜单配色
" 菜单
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
"IDE同化
set completeopt=longest,menu
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全			
let g:ycm_seed_identifiers_with_syntax=1
" 禁用语法
" let g:ycm_filepath_blacklist = {}
"语法白名单
let g:ycm_filepath_whitelist = {'html': 1, 'jsx': 1, 'xml': 1, 'css': 1}
