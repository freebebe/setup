if !exists('g:loaded_completion') | finish | endif

set completeopt=menuone,noinsert,noselect

let g:completion_enable_snippet = 'neosnippets'

" let g:completion_enable_auto_popup = 0
"===================auto disable

"===============================================================================
" basic snippets
	"snippet": snippet sources based on g:completion_enable_snippet

