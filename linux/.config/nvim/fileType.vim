"_______________________________________________________________________________
"                                                               filetype off {{{
filetype plugin on
set shell=zsh
set t_Co=256
" Z4-bit color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" autoCommit
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" run utf-8 (all)
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,big5,euc-jp,euc-kr,euc-tw

" fileType
set matchpairs=(:),[:],{:}
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md,.rb,.tsx,.ts,.jpg,.jpeg,.gif,.png,.vim

" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

" }}}___________________________________________________________________________

"_______________________________________________________________________________
"                                                                       EX  {{{

runtime ./after/ftplugin/css.rc.vim
runtime ./after/ftplugin/javascript.rc.vim
runtime ./after/ftplugin/coffee.rc.vim

" }}}___________________________________________________________________________
