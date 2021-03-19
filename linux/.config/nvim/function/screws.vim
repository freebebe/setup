"============================== clang-format
"----------------------------------------------
" map to <Leader> [f >>> j] in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>fj :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>fj :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

"============================== undotree
"----------------------------------------------
nnoremap <F5> :UndotreeToggle<CR>

"============================== accelerated-jk
"----------------------------------------------
" nmap j <Plug>(accelerated_jk_gj)
" nmap k <Plug>(accelerated_jk_gk)
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)

"============================== operator-surround
"----------------------------------------------
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

"============================== ale
"----------------------------------------------
nnoremap <silent><f8> :ALEFix<cr>

" nnoremap <silent><f8> :call AleFixResetView()<cr>
