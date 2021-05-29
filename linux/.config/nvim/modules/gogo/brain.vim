"color
" set background=dark
" colo github
colo light-delight
" colo  iceberg
  let g:lightline = {'colorscheme': 'iceberg'}

set rtp+=~/.fzf
" filetype off
filetype plugin on
set shell=fish
set t_Co=256

"文件代码形式utf-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr
"文件格式
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
  " JavaScript
  au BufNewFile,BufRead *.es6 setf javascript
  " TypeScript
  au BufNewFile,BufRead *.tsx setf typescript
  " Markdown
  au BufNewFile,BufRead *.md set filetype=markdown
  " Flow
  au BufNewFile,BufRead *.flow set filetype=javascript

"格式
"inside_be_wiki-PLUG   |  set nocompatible            "设置不兼容
set smarttab                "Use 'shiftwidth' when using <Tab> in front of a line. By default it's used only for shift commands (<, >).
set smartindent             "smart when using tabs
set autoindent
set expandtab
set vb t_vb=                "消警告提声
set laststatus=2            "显示状态行
set ruler                   "总是显示下行数
set showcmd                 "显示输入命令
set title                   "设置顶题
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


"缩进
filetype indent on          "自适应语言的智能缩进
set shiftwidth=2
set tabstop=2
set ai                      "Auto indent
set si                      "Smart indent
set backspace=start,eol,indent
set number                  "行号
set relativenumber          "递进行号

"=========================进退x***
set tabstop=4
set softtabstop=4
set backspace=2

"=========================代码折叠
" set foldenable
set nowrap                  "禁止折行
set nofoldenable			"启动vim时关闭折叠代码
" set foldmethod=indent       "z-f
    "manual        手工折叠
    "indent        缩进表示
    "expr        表达式折叠
    "syntax        语法定义折叠
    "diff        没有更改的文本折叠
    "maraker    标记折叠，默认：{{{和}}}

"=========================语法高亮-字典
syntax enable
syntax on
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertLeave,WinEnter * set nocursorline
