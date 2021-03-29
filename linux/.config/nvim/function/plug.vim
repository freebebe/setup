call plug#begin('~/.vim/plugged')
    Plug 'sheerun/vim-polyglot'                 "字典 to heavy
"--------syntax | language
" 士巴拿
    Plug 'preservim/tagbar'                     "预览大纲
    Plug 'rhysd/accelerated-jk'                 " speed j, k
    Plug 'wincent/ferret'                       " Enhanced Multi-file search and replace 光标下字符简易全局替换
    Plug 'tommcdo/vim-lion'                     " Align characters across lines 对齐运算符
    Plug 'romainl/vim-cool'                     " Clear Search Highlights automatically
    Plug 'rhysd/clever-f.vim'                   " Improvement to 'f' and 'F', 't', and 'T'
    Plug 'tomtom/tcomment_vim'                  "注释
            "gc | gcc | gC |
    Plug 'mg979/vim-visual-multi'		            "批量修改: {v+[C-N]}
    Plug 'kana/vim-operator-user'
        Plug 'rhysd/vim-operator-surround'      "test --()> (test)
            "sa (add)/| sd (delete)/| sr (rename)/
    Plug 'airblade/vim-gitgutter'               "git修改记录-异步
    " Plug 'vimwiki/vimwiki'
    " Plug 'tpope/vim-fugitive'                   "git
    "   Plug 'tpope/vim-rhubarb'                  "if fugitive is git, rhubarb is hub
    Plug 'easymotion/vim-easymotion'            "'/'标签字母快速跳转
    Plug 'AndrewRadev/splitjoin.vim'
            "gS to split a one-liner into multiple lines
            "gJ (with the cursor on the first line of a block) to join a block into a single-line statement.
"螺丝
    Plug 'Yggdroot/indentLine'                  "缩进线
    Plug 'alvan/vim-closetag'                   "Auto close (X)HTML tags
            " <table|   --[>]-->    <table>|</table>
            " :CloseTagToggleBuffer
            " :CloseTagEnableBuffer
            " :CloseTagDisableBuffer
    Plug 'andymass/vim-matchup'                 "Paren/def&end highlighting
    " Plug 'christoomey/vim-tmux-navigator'       "tmux lunach
    Plug 'mbbill/undotree'                      "undo history: [F5]
    Plug 'tpope/vim-eunuch'                     "filemanger ->  /:move//:mkdir//:rename//:delete//
    " Plug 'jreybert/vimagit'
    Plug 'wannesm/wmgraphviz.vim'				        "mind map
    " Plug 'lervag/vimtex'
    " Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }         "online
    Plug 'Vimjas/vim-python-pep8-indent'        "自动/定义缩进
    Plug '907th/vim-auto-save'                  "自动保存
    " Plug 'RRethy/vim-illuminate'                "高亮方标所在目标全文位置
    Plug 'itchyny/vim-cursorword'               "smpo
    Plug 'mhinz/vim-signify'                    "verion diff
    " Plug 'norcalli/nvim-colorizer.lua'          "css color
    Plug 'ap/vim-css-color'			            "css-color
"new tag
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
                                                " File finder, text finder, buffer finder
    Plug 'junegunn/fzf.vim'
    " Plug 'liuchengxu/vim-clap'
"WEB
    Plug 'godlygeek/tabular'                    "useful to line up text
    Plug 'Raimondi/delimitMate'                 "前后括制对齐
    Plug 'tyru/open-browser.vim'
        Plug 'tyru/open-browser-github.vim'
    Plug 'turbio/bracey.vim'                    "live local-server
    " Plug 'jaxbot/browserlink.vim'
"热熔胶
    Plug 'rhysd/vim-clang-format'               "pinkup the function be it just function 自动整理间距
    Plug 'mattn/emmet-vim'                      "htXml5-backnotes
    Plug 'editorconfig/editorconfig-vim'        "team统一风格
"油漆
    Plug 'itchyny/lightline.vim'			    "状态
    Plug 'junegunn/goyo.vim'                    "简化阅读
   "schemes
    " Plug '$HOME/.config/nvim/colors'
"规程
    " Plug 'dense-analysis/ale', {'for': ['javascript.jsx', 'javascript', 'jsx', 'rust', 'css']} "异步语法检查: https://github.com/dense-analysis/ale
    " Plug 'dense-analysis/ale'
    " Plug 'neomake/neomake'                      "Ale-fastVersion
"兔洞
    " Plug 'mileszs/ack.vim'                      "文本搜索：设置里并用t.s.s
"server
    " Plug 'rust-lang/cargo'                      "rust
    " Plug 'Quramy/tsuquyomi'                     "ts
    " Plug 'mxw/vim-jsx'                          "js
    " Plug 'jelera/vim-javascript-syntax'         "js
"---------------------------lsp
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'lighttiger2505/deoplete-vim-lsp'

"shou
    " Plug 'https://github.com/Quramy/tsuquyomi'    "ts
    " Plug 'prabirshrestha/asyncomplete.vim'
    " Plug 'nvim-lua/completion-nvim'               "deoplete -> LuaVersion
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }                    "目录树
        Plug 'kristijanhusak/defx-git'
    Plug 'Shougo/denite.nvim'
"---------------------------Omni-completion
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
    endif

    " Plug 'hrsh7th/vim-vsnip'
    " Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'Shougo/neosnippet.vim'
    " Plug 'SirVer/ultisnips'                     "snippets -> neosnippet-BKUP
        Plug 'Shougo/neosnippet-snippets'
        " Plug 'honza/vim-snippets'
    "
    " Plug 'Shougo/echodoc.vim'
    " Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/context_filetype.vim'
"---------------------------pakage
        " Plug 'autozimu/LanguageClient-neovim'           "server
        " Plug 'deoplete-plugins/deoplete-lsp'          "server
        " Plug 'Shougo/neco-syntax'                       "def
        " Plug 'Shougo/neco-vim'                          "VimLang
        " Plug 'deoplete-plugins/deoplete-jedi'           "python
        " Plug 'mhartington/nvim-typescript', {'do': 'sh ~/.vim/plugged/nvim-typescript/install.sh'}              "typescript
            " Plug 'HerringtonDarkholme/yats.vim'   "for type: syntax file
        " Plug 'racer-rust/vim-racer'                     "rust
        " Plug 'wokalski/autocomplete-flow'             "js
        " Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn add global tern'}       "js
        " Plug 'deoplete-plugins/deoplete-go'            "go

" wait for version 0.5 -------------|

    if has('nvim-0.5')
        Plug 'Shougo/deoplete-lsp'                                  " Autocompletion
        Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
        Plug 'neovim/nvim-lspconfig'
        Plug 'RRethy/vim-illuminate'                                " Highlight the same word as under cursor
        Plug 'glepnir/indent-guides.nvim'                           " Indentation Guides
        Plug 'nvim-lua/plenary.nvim'                                " Utilities for LUA
        Plug 'lewis6991/gitsigns.nvim'                              " Gitgutter
    endif
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        " Plug 'nvim-treesitter/playground'
    " Plug 'neovim/nvim-lspconfig'
    " Plug 'nvim-lua/completion-nvim'
    " Plug 'hrsh7th/vim-vsnip"

call plug#end()
