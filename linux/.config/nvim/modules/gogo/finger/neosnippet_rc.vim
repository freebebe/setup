" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '$HOME/.vim/plugged/vim-snippets/snippets'
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

command! -nargs=* Nes NeoSnippetEdit <args>
