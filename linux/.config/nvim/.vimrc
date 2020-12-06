"neovim plug
source ~/.config/nvim/plug.vim
source ~/.config/nvim/plug_setup.vim
source ~/.config/nvim/plug_nerdtree.vim
source ~/.config/nvim/plug_nerdcommenter.vim
source ~/.config/nvim/plug_wiki.vim
source ~/.config/nvim/plug_emmet.vim
source ~/.config/nvim/plug_markdown.vim
source ~/.config/nvim/plug_ctrlp.vim

"color
colo iceberg

" colo evening
	let g:lightline = {'colorscheme': 'iceberg'}

"setKey
nnoremap tn :tabnew<Space>
nnoremap tg :tabfirst<CR>
nnoremap tG :tablast<CR>
  inoremap <C-U> <C-G>u<C-U>          "挡c-U
  "保存
  nnoremap <C-s> :<CR>
  inoremap <C-s> <ESC>:w<CR>

"配置同步
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"IDE同化

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
set smarttab                "Use 'shiftwidth' when using <Tab> in front of a line. By default it's used only for shift commands (<, >).
set autoindent
set number                  "行号
set relativenumber          "递进行号
set vb t_vb=                "消警告提声
set laststatus=2            "显示状态行
set ruler                   "总是显示下行数
set nocompatible            "设置不兼容
set showcmd                 "显示输入命令
set title                   "设置顶题
set nobackup                "不备份

set complete-=i             "disable scanning included files
set complete-=t             "disable searching tags

set hlsearch                "Enable search highlighting.
set incsearch
set ignorecase              "搜索忽略大小写
set showmatch

set smartindent             "smart when using tabs
set cindent
set so=7                    "7行上下滚动始终在中间

"缩进
filetype indent on          "自适应语言的智能缩进
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set backspace=start,eol,indent

"=========================进退x***
set tabstop=4
set softtabstop=4
set backspace=2
set expandtab

"=========================语法高亮-字典
syntax enable
syntax on
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertLeave,WinEnter * set nocursorline

"======================十字定位线
set colorcolumn=80          "警示線
set cursorline
set cursorcolumn
  "colo
  highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

  highlight LineNr       cterm=none ctermfg=240 guifg=#2b506e guibg=#000000
 
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
set nowrap            "禁止折行
" set fooldmethod=indent
" set fooldmethod=syntax		"基于缩进或语法进行代码折叠
set nofoldenable			"启动vim时关闭折叠代码
set foldmethod=syntax

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

" For conceal markers.对隐藏标记
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Add asterisks in block comments 块标记*号
set formatoptions+=r


