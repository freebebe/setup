" save && save quie
nnoremap q :<C-u>q<CR>
" nnoremap Q :<C-u>qa!<CR>

"
nnoremap <Leader>t :<C-u>tabclose<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>t :<C-u>tabclose<CR>
nnoremap <Leader>w :<C-u>w<CR>
" nnoremap * *N

"question
" nmap ; :
" vmap ; :
" xmap ; :

nnoremap @ q
nnoremap j gj
nnoremap k gk

"jump
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

"setKey
" nnoremap <silent> :<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap vs :vs<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap sp :sp<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

" nnoremap tn :tabnew<Space>
nnoremap tn :tabnew<CR>
            \:<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

nnoremap tg :tabfirst<CR>
nnoremap tG :tablast<CR>
    inoremap <C-U> <C-G>u<C-U>          "挡c-U
    "保存
    nnoremap <C-s> :<CR>
    inoremap <C-s> <ESC>:w<CR>
