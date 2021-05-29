"_______________________________________________________________________________
"                                                                       neo{{{
"
" call neocompletelock
" Avoids conflicts with vim-multiple-cursors plugin
" Called once right before you start selecting multiple cursors
"---------------------------------------------------------------
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

let g:neosnippet#enable_completed_snippet = 1                       
let g:deoplete_enable_camel_case_completion = 1
let g:deoplete_enable_underbar_completion   = 1
let g:deoplete_enable_smart_case            = 1
let g:deoplete#enable_fuzzy_completion      = 1
"
" " default # of completions is 100, that's crazy
" let g:deoplete#max_list                     = 10
"
" " words less than 2 letters long aren't worth completing
let g:deoplete#auto_completion_start_length = 2
"
" " This makes sure we use neocomplcache completefunc instead of
" " the one in rails.vim, otherwise this plugin will crap out
let g:deoplete_force_overwrite_completefunc = 1

" }}}___________________________________________________________________________
