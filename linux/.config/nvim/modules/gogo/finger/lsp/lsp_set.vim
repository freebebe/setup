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
    \   }
    \   })   }
    let s:on_fallback = { command, position -> [
    \   cursor(position.line + 1, position.character + 1),
    \   command ==# 'vsplit' ? execute('vertical EffortGF', '') : execute('EffortGF', '')
    \   ]   }

    call lamp#feature#workspace#configure({
    \   'emmet': {},
    \   'html': {},
    \   'javascript': {},
    \   'typescript': {},
    \   'prettier': {},
    \   'stylusSupremacy': {},
    \   'Lua': {
    \       'completion': {
    \           'callSnippet': 'Replace',
    \       },
    \       'diagnostics': {                                                                     
    \       'enable': v:true,                                                                  
    \       'globals': [                                                                       
    \         'vim', 'describe', 'it', 'before_each', 'after_each'                             
    \       ],                                                                                 
    \     },                                                                                   
    \     'workspace': {                                                                       
    \       'library': s:lua_library, 
    \     }, 
    \   },
    })

" lsp
  let g:lsp_log_file = '~/.tmp/lsp.log'
  let g:lsp_fold_enabled = v:true
  let g:lsp_diagnostics_float_cursor = 1

  autocmd vimrc User lsp_setup call s:setup_vim_lsp()
  function s:setup_vim_lsp() abort
    call lsp#register_server({
    \   'name': 'intelephense',
    \   'cmd': { -> ['intelephense', '--stdio'] },
    \   'allowlist': ['php'],
    \   'root_uri': { -> lsp#utils#path_to_uri(lamp#findup(['.git', 'composer.json'])) },
    \ })
    call lsp#register_server({
    \   'name': 'clangd',
    \   'cmd': { -> ['clangd', '--background-index', '--clang-tidy'] },
    \   'allowlist': ['cpp', 'c'],
    \   'root_uri': { -> lsp#utils#path_to_uri(lamp#findup(['compile_commands.json', '.git'])) },
    \ })
    call lsp#register_server({
    \   'name': 'lua-language-server',
    \   'cmd': { server_info -> [
    \     expand('~/Develop/Repos/lua-language-server/bin/macOS/lua-language-server'),
    \     '-E',
    \     expand('~/Develop/Repos/lua-language-server/main.lua')
    \   ] },
    \   'allowlist': ['lua'],
    \   'root_uri': { -> lsp#utils#path_to_uri(lamp#findup(['.git'])) },
    \   'workspace_config': {
    \     'Lua': {
    \       'completion': {
    \         'callSnippet': 'Replace',
    \       },
    \       'diagnostics': {
    \         'enable': v:true,
    \         'globals': [
    \           'vim', 'describe', 'it', 'before_each', 'after_each'
    \         ],
    \       },
    \       'workspace': {
    \         'library': s:lua_library,
    \       },
    \     },
    \   }
    \ })   
    call lsp#register_server({
    \   'name': 'vscode-html-language-server',
    \   'cmd': { -> ['vscode-html-language-server', '--stdio'] },
    \   'allowlist': ['html'],
    \   'initialization_options': { -> {
    \     'embeddedLanguages': {
    \       'css': v:true,
    \       'html': v:true,
    \       'javascript': v:true,
    \     }
    \   } }
    \ })
  endfunction
