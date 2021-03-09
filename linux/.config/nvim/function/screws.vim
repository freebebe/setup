"==============================clang-format
" map to <Leader> [f >>> j] in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>fj :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>fj :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

"==============================undotree
nnoremap <F5> :UndotreeToggle<CR>


