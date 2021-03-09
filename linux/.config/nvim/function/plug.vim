"------------------------------
"---------plug-backup----------
"------------------------------
    "Plug 'davidhalter/jedi'                    "PYTHON
                                                "python不全/字典:    https://github.com/davidhalter/jedi
    "Plug 'ctrlpvim/ctrlp.vim'                   "模糊搜索
    "Plug 'FelikZ/ctrlp-py-matcher'              "ctrlp-python插件 : https://github.com/FelikZ/ctrlp-py-matcher
    "Plug 'pangloss/vim-javascript'             "java高亮
    "Plug 'junegunn/goyo.vim'                    "简化阅读
    "Plug 'turbio/bracey.vim'				    "h+c+j 补全
    "Plug 'aklt/plantuml-syntax'				"mind map
    "Plug 'ap/vim-css-color'			        "css-color
    "Plug 'hail2u/vim-css3-syntax'              "css高亮
    "Plug 'ycm-core/YouCompleteMe'
    "Plug 'vim-syntastic/syntastic'             "语法检查
    "Plug 'suan/vim-instant-markdown'           "markdown
    "Plug 'cormacrelf/vim-colors-github'         "为何用浅色背景:https://www.zhihu.com/question/20215618
    "---------->Plug 'Shougo/deoplete.nvim'
    "---------->if use vim8
              " if has('nvim')
                " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
              " else
                " Plug 'Shougo/deoplete.nvim'
                " Plug 'roxma/nvim-yarp'
                " Plug 'roxma/vim-hug-neovim-rpc'
    "---------->endif
"vim-plug>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
call plug#begin('~/.vim/plugged')
"格式
    Plug 'Yggdroot/indentLine'                  "缩进线
    Plug 'sheerun/vim-polyglot'                 "字典
        " Plug 'hail2u/vim-css3-syntax'               "css
        " Plug 'leafgarland/typescript-vim'           "typescript
        " Plug 'pangloss/vim-javascript'              "javascript
            " Plug 'jparise/vim-graphql'                  "gatsby
        " Plug 'slim-template/vim-slim'               "sy for vim
        " Plug 'rust-lang/rust.vim'                   "rust
        " Plug 'posva/vim-vue'                        "vue
        " Plug 'aliou/bats.vim'                       "bash
    " Plug 'aklt/plantuml-syntax'                 "plantuml-----> mindMap
"是巴拿
    Plug 'wincent/ferret'                       " Enhanced Multi-file search and replace 光标下字符简易全局替换
    Plug 'tommcdo/vim-lion'                     " Align characters across lines 对齐运算符
    Plug 'romainl/vim-cool'                     " Clear Search Highlights automatically
    Plug 'rhysd/clever-f.vim'                   " Improvement to 'f' and 'F', 't', and 'T'
    Plug 'preservim/nerdcommenter'			        "注释
    Plug 'terryma/vim-multiple-cursors'		      "批量修改: {v+[C-N]}
    Plug 'tpope/vim-surround'                   "hello world! >>>>> [hello] world!:
                                                "(https://gist.github.com/wilon/ac1fc66f4a79e7b0c161c80877c75c94)
    Plug 'airblade/vim-gitgutter'               "git修改记录-异步
    " Plug 'vimwiki/vimwiki'
    Plug 'tpope/vim-fugitive'                   "git
      Plug 'tpope/vim-rhubarb'                  "if fugitive is git, rhubarb is hub
    Plug 'Vimjas/vim-python-pep8-indent'        "自动/定义缩进
    Plug 'easymotion/vim-easymotion'            "'/'标签字母快速跳转
    Plug 'AndrewRadev/splitjoin.vim'
          "gS to split a one-liner into multiple lines
          "gJ (with the cursor on the first line of a block) to join a block into a single-line statement.
"螺丝
    Plug 'andymass/vim-matchup'                 "Paren/def&end highlighting
    Plug 'christoomey/vim-tmux-navigator'       "tmux lunach
    Plug 'mbbill/undotree'                      "undo history: [F5]
    Plug 'tpope/vim-eunuch'                     "filemanger ->  /:move//:mkdir//:rename//:delete//
    " Plug 'jreybert/vimagit'
    Plug 'wannesm/wmgraphviz.vim'				        "mind map
    " Plug 'lervag/vimtex'
    " Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }         "online
    Plug '907th/vim-auto-save'                  "自动保存
    " Plug 'RRethy/vim-illuminate'                "高亮方标所在目标全文位置
    Plug 'itchyny/vim-cursorword'             "smpo
    " Plug 'norcalli/nvim-colorizer.lua'          "css color
    Plug 'ap/vim-css-color'			        "css-color
"new tag
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }           " File finder, text finder, buffer finder
    Plug 'junegunn/fzf.vim'
    " Plug 'liuchengxu/vim-clap'
"WEB
    Plug 'godlygeek/tabular'                    "useful to line up text
    Plug 'Raimondi/delimitMate'                 "前后括制对齐
    " Plug 'tyru/open-browser.vim'
"热熔胶
    Plug 'rhysd/vim-clang-format'               "pinkup the function be it just function 自动整理间距
    Plug 'mattn/emmet-vim'                      "htXml5-backnotes
    Plug 'editorconfig/editorconfig-vim'        "team统一风格
"油漆
    " Plug 'DNonov/light-delight'
    Plug 'itchyny/lightline.vim'			          "状态
"规程
    " Plug 'dense-analysis/ale'                   "异步语法检查: https://github.com/dense-analysis/ale
    Plug 'neomake/neomake'                      " ale fastVersion
    " Plug 'SirVer/ultisnips'                     "PYTHON补全
      " Plug 'honza/vim-snippets'
"兔洞
    " Plug 'mileszs/ack.vim'                      "文本搜索：设置里并用t.s.s
"server
    " Plug 'rust-lang/cargo'                      "rust
    Plug 'Quramy/tsuquyomi'                     "ts
    " Plug 'mxw/vim-jsx'                          "js
    " Plug 'jelera/vim-javascript-syntax'                          "js
"shou
    " Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }                    "目录树
        Plug 'kristijanhusak/defx-git'
    Plug 'Shougo/denite.nvim'
"---------------------------deop
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
    endif

    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'

    Plug 'Shougo/echodoc.vim'
"---------------------------pakage
        " Plug 'autozimu/LanguageClient-neovim'           "server
        " Plug 'deoplete-plugins/deoplete-lsp'          "server
            " Plug 'neovim/nvim-lspconfig'              "server
        Plug 'Shougo/neco-syntax'                       "def
        Plug 'Shougo/neco-vim'                          "VimLang
        Plug 'deoplete-plugins/deoplete-jedi'           "python
        " Plug 'mhartington/nvim-typescript', {'do': 'sh ~/.vim/plugged/nvim-typescript/install.sh'}              "typescript
            " Plug 'HerringtonDarkholme/yats.vim'   "for type: syntax file
        Plug 'racer-rust/vim-racer'                     "rust
        Plug 'wokalski/autocomplete-flow'             "js
        Plug 'carlitux/deoplete-ternjs', { 'do': ':yarn add global tern'}       "js
        " Plug 'deoplete-plugins/deoplete-go'            "go

" wait for version 0.5 -------------|

    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Plug 'neovim/nvim-lspconfig'                                                                                                            
    " Plug 'nvim-lua/completion-nvim'

call plug#end()
