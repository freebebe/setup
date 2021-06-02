"______________________________________________________________________________
"                                                                       LINK{{{
"
"
source $HOME/.config/nvim/rule.vim
source $HOME/.config/nvim/quickKeys.vim


"______________________________________________________________________________
"                                                                 Link : Plug{{{
"

source $HOME/.config/nvim/screws.vim

"______________________________________________________________________________
"                                                                      color{{{
"
colo whiteBlue
"set background=light

if exists("&termguicolors") && exists("&winblend")
  let g:neosolarized_termtrans=1
  " runtime $HOME/.config/nvim/colors/whiteBlue.vim
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
endif

