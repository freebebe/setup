"_______________________________________________________________________________
"                                                                   quick quie
inoremap <C-U> <C-G>u<C-U>          "挡c-U
    nnoremap q :<C-u>q<CR>
    " nnoremap Q :<C-u>qa!<CR>
    " save
    " nnoremap <C-s> :<CR>
    nnoremap <C-s> :<C-u>w<CR>

"
nnoremap <Leader>t :<C-u>tabclose<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>t :<C-u>tabclose<CR>
nnoremap <Leader>w :<C-u>w<CR>
" nnoremap * *N

"_______________________________________________________________________________
"                                                                       question
" nmap ; :
" vmap ; :
" xmap ; :

nnoremap @ q
nnoremap j gj
nnoremap k gk

"_______________________________________________________________________________
"                                                                           jump
nnoremap H 20h
nnoremap J 10j
nnoremap K 10k
nnoremap L 20l
nnoremap zk 5H
nnoremap zj 5L
xnoremap H 20h
xnoremap J 10j
xnoremap K 10k
xnoremap L 20l
xnoremap zk 5H
xnoremap zj 5L

" nnoremap <expr> <C-f> <SID>scroll(+4)
" nnoremap <expr> <C-u> <SID>scroll(-4)

nnoremap gj J

"Preserves indentation while pasting text from the clipboard
" nnoremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>

" nnoremap tn :tabnew<Space>
nnoremap tn :tabnew<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap tg :tabfirst<CR>
nnoremap tG :tablast<CR>
