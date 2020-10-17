"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')
"格式
    Plug 'Yggdroot/indentLine'              "缩进线
    Plug 'sheerun/vim-polyglot'             "字典
"是巴拿
	Plug 'preservim/nerdcommenter'			"注释
	Plug 'terryma/vim-multiple-cursors'		
    "{v-block+[C-N]}批量修改: 
    "(https://github.com/terryma/vim-multiple-cursors/blob/master/README.md)
    Plug 'tpope/vim-surround'               
    "hello world! >>>>> [hello] world!:     
    "(https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94)
    Plug 'airblade/vim-gitgutter'           "git修改记录-异步
    Plug 'vimwiki/vimwiki'
    Plug 'tyru/open-browser.vim'           "browser
"螺丝
    Plug 'scrooloose/nerdtree'              "目录树
	" Plug 'itchyny/lightline.vim'			"状态
    "Plug 'junegunn/goyo.vim'                "简化阅读
    "Plug 'jreybert/vimagit'
    Plug 'aklt/plantuml-syntax'				"mind map
"new tag
	Plug 'junegunn/fzf.vim'
	Plug 'liuchengxu/vim-clap'
"WEB
    "Plug 'hail2u/vim-css3-syntax'           "css高亮
    Plug 'Raimondi/delimitMate'             "前后括制对齐
    "Plug 'pangloss/vim-javascript'          "java高亮
    " Plug 'turbio/bracey.vim'				"h+c+j 补全
	"Plug 'ap/vim-css-color'			        "css-color
     Plug 'suan/vim-instant-markdown'     "markdown
"热熔胶
     " Plug 'ycm-core/YouCompleteMe'
     Plug 'mattn/emmet-vim'                 "htXml5-backnotes
   " Plug 'SirVer/ultisnips'                "PYTHON补全
    " Plug 'honza/vim-snippets'
   " Plug 'davidhalter/jedi'                "PYTHON
   " "python不全/字典:    https://github.com/davidhalter/jedi
"油漆
    " Plug 'cormacrelf/vim-colors-github'
  "----------------------"为何用浅色背景:https://www.zhihu.com/question/20215618
     "Plug 'morhetz/gruvbox'
    " Plug 'yuttie/inkstained-vim'
    " Plug 'atelierbram/Base2Tone-vim'
    " Plug 'altercation/vim-colors-solarized'
    " Plug 'atelierbram/Base2Tone-vim'
    " Plug 'mswift42/themecreator'
    " Plug 'mswift42/vim-themes'
	Plug 'arcticicestudio/nord-vim'
"规程
    " Plug 'vim-syntastic/syntastic'        
    " "语法检查
      Plug 'dense-analysis/ale'             
      "异步:https://github.com/dense-analysis/ale
"兔洞
    " Plug 'ctrlpvim/ctrlp.vim'
    "模糊搜索
    " Plug 'FelikZ/ctrlp-py-matcher'
    "ctrlp-python插件 : https://github.com/FelikZ/ctrlp-py-matcher
call plug#end()

"----------------------------------------------------\
"------------------------vim--------------------------|
"----------------------------------------------------/
"setKey
nnoremap tn :tabnew<Space>
nnoremap tg :tabfirst<CR>
nnoremap tG :tablast<CR>

"配置同步
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"网页同步
nnoremap ,v :exec '!exec firefox %'<CR>
" 默认标题
set title
"Auto reload if file was changed somewhere else (for autoread)
au CursorHold * checktime

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
set nomodeline      "modeline漏洞


"turn bakcup off, since most stuff is in SVN, etc.aanyway
set nowritebackup
set noswapfile
set nobackup

set autoread        "外部检测auto

set wildmenu        "c-n & c-p
set display+=lastline

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至 vim
nmap <Leader>p "+p

"========================= 折叠
set foldenable            "允许折叠
set fdm=syntax            " 按语法折叠
set fdm=manual            "手动
set foldmethod=indent
set foldnestmax=3
set nofoldenable


set novisualbell            "no闪烁

set vb t_vb=                 "消警告提声
set noerrorbells
set visualbell

set number                    "行号
set relativenumber            "递进行号

" Use dash as word separator.
set iskeyword+=-

" show mode in statusbar, not separately.
set noshowmode

" Enable mouse for scrolling and window resizing.
" set mouse=a

" Save up to 100 marks, enable capital marks.
set viminfo='100,f1

"=========================set relativenumber            "相对行号
set laststatus=2            "显示状态行
set ruler            "总是显示下行数
set showcmd                "显示输入命令
" set list                "显示Tab和空格

"=========================语法高亮-字典
syntax enable
syntax on

"=========================进退x***
set tabstop=4
set softtabstop=4
set backspace=2
set expandtab

"Use 'shiftwidth' when using <Tab> in front of a line. By default it's used only for shift commands (<, >).
set smarttab

filetype indent on            "自适应语言的智能缩进

set autoindent

set hlsearch                "Enable search highlighting.
set incsearch
set ignorecase
set showmatch

set smartindent
set cindent
"
"======================十字定位线
"set colorcolumn=80             "警示線
" set cursorline
" set cursorcolumn
"
" highlight CursorLine cterm=none ctermbg=236
" highlight CursorColumn cterm=none ctermbg=236
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

" Use Silver Searcher for CtrlP plugin (if available) Fallback to git ls-files for fast listing. Because we use fast strategies, disable caching.
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git',
    \ 'cd %s && git ls-files . -co --exclude-standard',
    \ 'find %s -type f' ]

" Make sure pasting in visual mode doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

"=========================智能当前行高亮
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertLeave,WinEnter * set nocursorline

"=========================关键字补全
set complete-=i                "disable scanning included files
set complete-=t                "disable searching tags

"=========================向,上游
if has('path_extra')
  setglobal tags-=./tags tags^=./tags;
endif

"=========================改键
" imap <TAB> <C-N>
" imap <S-TAB> <C-P>
inoremap <C-U> <C-G>u<C-U>          "挡c-U
"保存
nnoremap <C-s> :<CR>
inoremap <C-s> <ESC>:w<CR>

"Set minimum window size to 79x5.
" set winwidth=79
" set winheight=5
" set winminheight=5

"Wrap lines by default
set showbreak=" "

"======================加亮不加粗
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

"======================配色
set t_Co=256
set background=dark " or light if you prefer the light version
" colo github
colo nord
" set termguicolors
" colorscheme soft-stone
        " colorscheme inkstained
        "colorscheme github
                " let g:lightline = {'colorscheme': 'github'}
                " let g:github_colors_soft = 1               "background
    
">>>>>>>>>>Base2Tone
" syntax enable
"set background=light
" Base2Tone Dark
" colorscheme Base2Tone_EveningDark
" or any of the other schemes:
" colorscheme Base2Tone_MorningDark
" colorscheme Base2Tone_SeaDark
" colorscheme Base2Tone_SpaceDark
" colorscheme Base2Tone_EarthDark
" colorscheme Base2Tone_ForestDark
" colorscheme Base2Tone_FieldDark
" colorscheme Base2Tone_GardenDark
" colorscheme Base2Tone_DesertDark
" colorscheme Base2Tone_LakeDark
" colorscheme Base2Tone_MeadowDark
" colorscheme Base2Tone_DrawbridgeDark
" colorscheme Base2Tone_MallDark
" colorscheme Base2Tone_SuburbDark
" colorscheme Base2Tone_LavenderDark
" colorscheme Base2Tone_PoolDark
" colorscheme Base2Tone_PorchDark
" colorscheme Base2Tone_HeathDark
" colorscheme Base2Tone_CaveDark
" colorscheme Base2Tone_MotelDark

" Base2Tone Light
" colorscheme Base2Tone_EveningLight
" colorscheme Base2Tone_MorningLight
" colorscheme Base2Tone_SeaLight
" colorscheme Base2Tone_SpaceLight
" colorscheme Base2Tone_EarthLight
" colorscheme Base2Tone_ForestLight
" colorscheme Base2Tone_FieldLight
" colorscheme Base2Tone_GardenLight
" colorscheme Base2Tone_DesertLight
" colorscheme Base2Tone_LakeLight
" colorscheme Base2Tone_MeadowLight
" colorscheme Base2Tone_DrawbridgeLight
" colorscheme Base2Tone_MallLight
" colorscheme Base2Tone_SuburbLight
" colorscheme Base2Tone_LavenderLight
" colorscheme Base2Tone_PoolLight
" colorscheme Base2Tone_PorchLight
" colorscheme Base2Tone_HeathLight
" colorscheme Base2Tone_CaveLight
" colorscheme Base2Tone_MotelLight

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
map <F9> :NERDTreeToggle<CR>   

"位设
" let g:NERDTreeWinPos='right'

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
set nocompatible            "kill-vim一致性
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
" let g:jedi#auto_initialization = 1
" autocmd FileType python setlocal omnifunc=jedi#completions

"================javascript-highlight=================
let javascript_enable_domhtmlcss = 1

"================emmet-html&css->deful        (C=ctrl-)=====================
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall      只在html,css作用  
"
" let g:user_emmet_leader_key='C-y'
" autocmd filetype *html* imap <c-_> <c-y>/
" autocmd filetype *html* map <c-_> <c-y>/
"
let g:user_emmet_expandabbr_key = '<F2>'
let g:user_emmet_leader_key= '<C-e>'

"================ultisnips==============================
let g:UltiSnipsUsePythonVersion =2
let g:UltiSnipsExpandTrigger    ="<c-p>"
let g:UltiSnipsListSnippets          ="<c-l>"
let g:UltiSnipsJumpForwardTrigger    ="<c-j>"
let g:UltiSnipsJumpBackwardTrigger   ="<c-k>"

"================syntastic====================
let g:syntastic_java_javac_classpath=$CLASS_PATH

"================ctrl-plug=====================
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

"================emmet================
"map <F3> <C-\>

"===============YCM=====================
let g:ycm_clangd_binary_path = "~/Progm-plug/clang+llvm"
" YCM 补全菜单配色
" 菜单
" highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
" highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
"IDE同化
set completeopt=longest,menu
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=0
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
"电动是巴拿
let g:ycm_auto_trigger=1
let g:ycm_semantic_triggers = {
    \   'css': [ 're!^', 're!^\s+', ': ' ],
    \   'scss': [ 're!^', 're!^\s+', ': ' ],
    \ }
        " let g:ycm_semantic_triggers = {
        " \'c' : ['->', '    ', '.', ' ', '(', '[', '&'],
        " \'cpp,objcpp' : ['->', '.', ' ', '(', '[', '&', '::'],
        " \'perl' : ['->', '::', ' '],
        " \'php' : ['->', '::', '.'],
        " \'cs,java,javascript,d,vim,python,perl6,scala,vb,elixir,go' : ['.'],
        " \'ruby' : ['.', '::'],
        " \'lua' : ['.', ':'],
        " \'scss,css': [ 're!^\s{2,4}', 're!:\s+' ],
        " \'html': ['<', '"', '</', ' '],
        " \'javascript': ['.', 're!(?=[a-zA-Z]{3,4})'],
        " \}
endif

"============================vim-gitgutter
function! GitStatus()
 let [a,m,r] = GitGutterGetHunkSummary()
 return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

"============================markdown
filetype plugin on
"Uncomment to override defaults:
""let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
""let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
""let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
""let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
""let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
let g:instant_markdown_browser = "chromium --new-window"
