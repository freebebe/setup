"======================================
"                   LINK
"======================================
source $HOME/.config/nvim/gogo/brain/eyes/polyglot.vim
"
source $HOME/.config/nvim/function/plug.vim
source $HOME/.config/nvim/function/rule.vim
source $HOME/.config/nvim/gogo/foot/quickKeys.vim

">>>>>>
"color    for inside
">>>>>>
" set background=dark
  " let g:lightline = {'colorscheme': 'iceberg'}
colo whiteBlue      "local color 
" colo dicul
" colo approid

"====================================
"               Link : Plug          
"====================================
source $HOME/.config/nvim/function/screwdriver.vim
source $HOME/.config/nvim/function/screws.vim
"==============================ShouGo-Link
source $HOME/.config/nvim/gogo/finger/deoplete.rc.vim
" source $HOME/.config/nvim/gogo/finger/deoXcomplete.vim
" source $HOME/.config/nvim/gogo/finger/deoplete-lsp.vim
source $HOME/.config/nvim/gogo/finger/denite.vim
source $HOME/.config/nvim/gogo/finger/defx.vim
" source $HOME/.config/nvim/gogo/finger/deo-echodoc.vim

"----------------fix_deoplete
" source $HOME/.config/nvim/gogo/finger/fix_deoplete_in_cursors.vim

source $HOME/.config/nvim/gogo/brain/fzf.vim
source $HOME/.config/nvim/gogo/brain/ale.vim
" source $HOME/.config/nvim/gogo/brain/neomake.vim

source $HOME/.config/nvim/gogo/hands/lightline.vim



"===================================
"               color              >
"===================================

">>>>>>
"color    for outside
">>>>>>
if exists("&termguicolors") && exists("&winblend")
  let g:neosolarized_termtrans=1
  " runtime ./colors/solarized_true.vim
  runtime ~/.config/nvim/plug/iceberg.vim
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
endif

