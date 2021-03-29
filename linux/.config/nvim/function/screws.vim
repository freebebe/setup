"_______________________________________________________________________________
"                                                                   clang-format
" map to <Leader> [f >>> j] in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>fj :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>fj :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>


"_______________________________________________________________________________
"                                                                       undotree
nnoremap <F5> :UndotreeToggle<CR>

"_______________________________________________________________________________
"                                                                 accelerated-jk
" nmap j <Plug>(accelerated_jk_gj)
" nmap k <Plug>(accelerated_jk_gk)
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)

"_______________________________________________________________________________
"                                                               operator-surround
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)

"_______________________________________________________________________________
"                                                                           ale
" nmap <Leader>al <Plug>(ale_next)
nnoremap <silent><f9> :ALEFix<cr>
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)
" nnoremap <silent><f8> :call AleFixResetView()<cr>

"_______________________________________________________________________________
"                                                                       tagbar
nmap <F8> :TagbarToggle<CR>


"_______________________________________________________________________________
"                                                                       deoplete

" <CR>: close popup and save indent.
"----------------------------
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

"                                          <TAB>: completion.
"------------------------------------------------------------

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"                                    <S-TAB>: completion back.
"------------------------------------------------------------

inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"
"
inoremap <silent><expr><C-g>       deoplete#manual_complete('tabnine')
inoremap <silent><expr><C-e>       deoplete#cancel_popup()
inoremap <silent><expr><C-l>       deoplete#complete_common_string()

"================<CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"
endfunction

" call deoplete#custom#option('candidate_marks',
"       \ ['A', 'S', 'D', 'F', 'G'])
" inoremap <expr>A       pumvisible() ? deoplete#insert_candidate(0) : 'A'
" inoremap <expr>S       pumvisible() ? deoplete#insert_candidate(1) : 'S'
" inoremap <expr>D       pumvisible() ? deoplete#insert_candidate(2) : 'D'
" inoremap <expr>F       pumvisible() ? deoplete#insert_candidate(3) : 'F'
" inoremap <expr>G       pumvisible() ? deoplete#insert_candidate(4) : 'G'

"_______________________________________________________________________________
"                                                                       neosnippet
"
imap <expr><C-l> pumvisible() ?
      \ "\<C-y><Plug>(neosnippet_expand_or_jump)"
      \ : "<Plug>(neosnippet_expand_or_jump)"
"imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)

"_______________________________________________________________________________
"                                                                           fzf
"
nnoremap <silent><c-g> :RG<cr>
nnoremap <silent><c-f> :Files<CR>

" _______________________________________________________________________________
"                                                                           vsnip
"
" Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"
" " Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"
" " Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
"
" " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" " See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap <expr> <Tab> <Plug>(vsnip-select-text)
" xmap <expr> <Tab> <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)
"
