call plug#begin('~/.config/nvim/plug')
"语法检查
	Plug 'dense-analysis/ale'             	"异步:https://github.com/dense-analysis/ale

"color
	Plug 'cocopon/iceberg.vim'
	
"emmet-html5
	Plug 'mattn/emmet-vim'                 	"htXml5-backnotes

"search
	Plug 'junegunn/fzf.vim'									"max ctrlp
	Plug 'ctrlpvim/ctrlp.vim'								"max fzf
    Plug 'FelikZ/ctrlp-py-matcher'				"ctrlp-python插件 : https://github.com/FelikZ/ctrlp-py-matcher
	Plug 'liuchengxu/vim-clap'

"注释
	Plug 'preservim/nerdcommenter'			

"{v+[C-N]}批量修改: 
	Plug 'terryma/vim-multiple-cursors'		

"树状图
	Plug 'scrooloose/nerdtree'              "目录树

"格式
	Plug 'Yggdroot/indentLine'              "缩进线
	Plug 'sheerun/vim-polyglot'             "字典
	Plug 'Raimondi/delimitMate'             "前后括制对齐
	Plug 'itchyny/lightline.vim'						"状态栏

"git
	Plug 'airblade/vim-gitgutter'           "git修改记录-异步

"markdown
	Plug 'suan/vim-instant-markdown', {'for': 'markdown'}     		"markdown

call plug#end()
