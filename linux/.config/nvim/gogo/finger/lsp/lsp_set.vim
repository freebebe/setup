"lsc
let g:lsc_server_commands = {
\   'go': ['gopls'],
\   'cpp': ['clangd', '--background-index', '--cland-tidy'],
\   'typescript': ['typescript-language-server', '--stdio'],
\   'php': {
\       'command': expand('~/lsc_debug.sh'),
\       'message_hooks': {
\           'initialize': {
\               'initializationOptions': {
\                   'stragePath': expand('~/.cache/aiueo')
\                   }
\               }
\           }
\       }
\   'vim': ['vim-language-server', '--stdio']
\   }
endif

" lamp
autocmd! vimrc User lamp#initialized call s:on_lamp_initialized()
function! s:on_lamp_initialized() abort
    let s:on_location = { locations -> candle#start({
    \   'item': map(locations, { i, location -> extend(location, { 'id': i, 'title': location.filename, 'filename': location.filename }) })
    \   }, {
    \       'action': {
    \           'default': 'edit'
    \}
    }
    })}
