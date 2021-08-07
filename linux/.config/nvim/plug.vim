if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('$HOME/.nvim/plugged')

" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
Plug 'Raimondi/delimitMate'
" Plug 'abecodes/tabout.nvim'
Plug 'tomtom/tcomment_vim'

if has ("nvim")
    Plug 'hoob3rt/lualine.nvim'

    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neosnippet.vim'
        Plug 'Shougo/neosnippet-snippets'


    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/completion-nvim'
                " completion-engine

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'Yggdroot/indentLine'

    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'blackCauldron7/surround.nvim'

    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'lewis6991/gitsigns.nvim'
endif

Plug 'norcalli/nvim-colorizer.lua'
Plug 'mattn/emmet-vim'

Plug 'rktjmp/lush.nvim'

call plug#end()
