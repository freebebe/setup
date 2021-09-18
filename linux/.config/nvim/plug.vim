if has("nvim")
    let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin('$HOME/.nvim/plugged')

" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rhubarb'
" Plug 'abecodes/tabout.nvim'
Plug 'tomtom/tcomment_vim'

if has ("nvim")
    Plug 'hoob3rt/lualine.nvim'

    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'neovim/nvim-lspconfig'
    " Plug 'nvim-lua/completion-nvim'
    Plug 'glepnir/lspsaga.nvim'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'

    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip' 

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        " Plug 'JoosepAlviste/nvim-ts-context-commentstring'
                " gcc 

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'Yggdroot/indentLine'

    Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'blackCauldron7/surround.nvim'

    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'lewis6991/gitsigns.nvim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'windwp/nvim-autopairs'
    "{} () <>

endif

Plug 'mattn/emmet-vim'
Plug 'norcalli/nvim-colorizer.lua'

Plug 'kchmck/vim-coffee-script'

call plug#end()
