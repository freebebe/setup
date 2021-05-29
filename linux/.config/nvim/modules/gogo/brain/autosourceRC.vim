augroup autosource
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END
