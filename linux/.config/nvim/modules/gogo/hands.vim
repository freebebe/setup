"------------------------------
"---------plug-backup----------
"------------------------------
    "Plug 'tyru/open-browser.vim'                "browser
    "Plug 'junegunn/goyo.vim'                   "简化阅读
    "Plug 'SirVer/ultisnips'                     "PYTHON补全
    "Plug 'honza/vim-snippets'
    "Plug 'davidhalter/jedi'                    "PYTHON     
                                                "python不全/字典:    https://github.com/davidhalter/jedi
    "Plug 'pangloss/vim-javascript'             "java高亮
    "Plug 'turbio/bracey.vim'				    "h+c+j 补全
    "Plug 'aklt/plantuml-syntax'				"mind map
    "Plug 'ap/vim-css-color'			        "css-color
    "Plug 'hail2u/vim-css3-syntax'              "css高亮
    "Plug 'ycm-core/YouCompleteMe'
    "Plug 'vim-syntastic/syntastic'             "语法检查
    "Plug 'suan/vim-instant-markdown'           "markdown
"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.config/nvim/plugged')
"格式
    Plug 'Yggdroot/indentLine'                  "缩进线
    Plug 'sheerun/vim-polyglot'                 "字典
    Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install()}}
"是巴拿
    Plug 'preservim/nerdcommenter'			    "注释
    Plug 'terryma/vim-multiple-cursors'		    "{v+[C-N]}批量修改: 
    Plug 'tpope/vim-surround'                   "hello world! >>>>> [hello] world!:     
                                                "(https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94)
    Plug 'airblade/vim-gitgutter'               "git修改记录-异步
    " Plug 'vimwiki/vimwiki'
    Plug 'editorconfig/editorconfig-vim'        "team统一风格
    Plug 'tpope/vim-fugitive'                   "git
      Plug 'tpope/vim-rhubarb'                  "if fugitive is git, rhubarb is hub
"螺丝
    Plug 'scrooloose/nerdtree'                  "目录树
    Plug 'tpope/vim-eunuch'                     "filemanger ->  /:move//:mkdir//:rename//:delete//
    Plug 'itchyny/lightline.vim'			    "状态
    Plug 'jreybert/vimagit'
    Plug 'wannesm/wmgraphviz.vim'				"mind map
    Plug 'lervag/vimtex'
    Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }         "online
    Plug '907th/vim-auto-save'                  "自动保存
"new tag
    Plug 'junegunn/fzf.vim'
    Plug 'liuchengxu/vim-clap'
"WEB
    Plug 'godlygeek/tabular'                    "useful to line up text
    Plug 'Raimondi/delimitMate'                 "前后括制对齐
    Plug 'AndrewRadev/splitjoin.vim'            
          "gS to split a one-liner into multiple lines
          "gJ (with the cursor on the first line of a block) to join a block into a single-line statement.
"热熔胶
    Plug 'rhysd/vim-clang-format'               "pinkup the function be it just function
    Plug 'mattn/emmet-vim'                      "htXml5-backnotes
"油漆
    Plug 'cocopon/iceberg.vim'
    " Plug 'cormacrelf/vim-colors-github'         "为何用浅色背景:https://www.zhihu.com/question/20215618
    Plug 'DNonov/light-delight'
"规程
    Plug 'dense-analysis/ale'                   "异步语法检查:https://github.com/dense-analysis/ale
"兔洞
    Plug 'mileszs/ack.vim'                      "文本搜索：设置里并用t.s.s
    Plug 'ctrlpvim/ctrlp.vim'                   "模糊搜索
    Plug 'FelikZ/ctrlp-py-matcher'              "ctrlp-python插件 : https://github.com/FelikZ/ctrlp-py-matcher
"only nervim
    " Plug 'Shougo/defx.nvim'                     "need pynvim
    " Plug 'Shougo/denite.nvim'
call plug#end()
