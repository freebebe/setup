" let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden -g "!{node_modules,.git,tmp,storage}"'

nnoremap <silent><c-g> :RG<cr>
nnoremap <silent><c-f> :Files<CR>

command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--margin=1,2']}), <bang>0)

let g:fzf_history_dir = '~/.cache/nvim/fzf-history'
let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'border': 'top' } }

augroup FzfAutocmd
    autocmd!
    " autocmd FileType fzf call InvertBackground()
        " \| autocmd BufLeave <buffer> call ResetBackground()
    autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
    autocmd FileType fzf tnoremap <buffer> <C-k> <Up>
augroup END

let g:fzf_action = {
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'ctrl-t': 'tab split',
    \ }

function! RipgrepFzf(query, fullscreen)
let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
let initial_command = printf(command_fmt, shellescape(a:query))
let reload_command  = printf(command_fmt, '{q}')
let spec            = {
        \ 'options': [
        \ '--phony',
        \ '--query',
        \ a:query,
        \ '--bind',
        \ 'change:reload:'.reload_command,
        \ '--layout=reverse',
        \ '--margin=0,1',
        \ '--preview-window=down:50%',
        \ '--color=bg+:#2C323C,border:#5C6370,spinner:#E06C75,hl:#E06C75,fg:#FCFCFC,info:#5C6370:italic,pointer:#E06C75,fg+:#FFE082:bold,prompt:#82AAFF,hl+:#E06C75'
  \ ]}

call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
