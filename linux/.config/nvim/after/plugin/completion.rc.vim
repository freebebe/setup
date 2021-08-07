if !exists('g:loaded_completion') | finish | endif

set completeopt=menuone,noinsert,noselect

" let g:completion_enable_snippet = 'vim-vsnip'
let g:completion_enable_snippet = 'neosnippets'
" let g:completion_enable_snippet = 'Deoppet'


"===============================================================================
" basic snippets
	"snippet": snippet sources based on g:completion_enable_snippet
