"neovim plug
source ~/.config/nvim/plug.vim
source ~/.config/nvim/plug_setup.vim
source ~/.config/nvim/plug_nerdtree.vim
source ~/.config/nvim/plug_nerdcommenter.vim
source ~/.config/nvim/plug_wiki.vim
source ~/.config/nvim/plug_emmet.vim
source ~/.config/nvim/plug_markdown.vim
source ~/.config/nvim/plug_ctrlp.vim
"
"color
colo iceberg
	let g:lightline = {'colorscheme': 'iceberg'}
"setKey
nnoremap tn :tabnew<Space>
nnoremap tg :tabfirst<CR>
nnoremap tG :tablast<CR>
  inoremap <C-U> <C-G>u<C-U>          "挡c-U
  "保存
  nnoremap <C-s> :<CR>
  inoremap <C-s> <ESC>:w<CR>

"格式
set number                  "行号
set relativenumber          "递进行号
set vb t_vb=                "消警告提声
set laststatus=2            "显示状态行
set ruler                   "总是显示下行数
set showcmd                 "显示输入命令
filetype indent on          "自适应语言的智能缩进

set hlsearch                "Enable search highlighting.
set incsearch
set ignorecase
set showmatch

set smartindent
set cindent
set so=7                    "7行上下滚动始终在中间

"=========================语法高亮-字典
syntax enable
syntax on
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertLeave,WinEnter * set nocursorline

"======================十字定位线
set colorcolumn=80          "警示線
 set cursorline
 set cursorcolumn
 
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
