let g:neosnippet#snippets_directory = '$HOME/.config/nvim/snippets'
let g:neosnippet#disable_runtime_snippets = { '_' : 1 }

command! -nargs=* Nes NeoSnippetEdit <args>
