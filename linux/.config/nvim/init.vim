" source ~/.config/nvim/.vimrc
 source ~/.vimrc
" source ~/.config/nvim/bkup/.vimrc

"====================deo
"====================O
"runtime ~/.config/nvim/gogo/brain.vim
"runtime ~/.config/nvim/gogo/hands.vim
"runtime ~/.config/nvim/gogo/finger.vim
"runtime ~/.config/nvim/gogo/foot.vim



"true color
if exists("&termguicolors") && exists("&winblend")
  let g:neosolarized_termtrans=1
  " runtime ./colors/solarized_true.vim
  runtime ~/.config/nvim/plug/iceberg.vim
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
endif

