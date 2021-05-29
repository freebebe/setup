"______________________________________________________________________________
"                                                                       LINK{{{
"
luafile $HOME/.config/nvim/lua/Plug/polyglot.lua
"
source $HOME/.config/nvim/plug.vim
source $HOME/.config/nvim/rule.vim
source $HOME/.config/nvim/quickKeys.vim


"______________________________________________________________________________
"                                                                 Link : Plug{{{
"

source $HOME/.config/nvim/screwdriver.vim
source $HOME/.config/nvim/screws.vim
"==============================ShouGo-Link
" source $HOME/.config/nvim/gogo/finger/deoplete_rc.vim
" source $HOME/.config/nvim/gogo/finger/deo-neo.vim
" source $HOME/.config/nvim/gogo/finger/deo-neo_rc.vim
source $HOME/.config/nvim/Plug/deoRc.vim
source $HOME/.config/nvim/Plug/denite.vim
source $HOME/.config/nvim/Plug/defx.vim
" source $HOME/.config/nvim/gogo/finger/neosnippet_rc.vim
" source $HOME/.config/nvim/gogo/finger/neosnippets_2.vim
" source $HOME/.config/nvim/gogo/finger/deoXcomplete.vim
" source $HOME/.config/nvim/gogo/finger/deoplete-lsp.vim
" source $HOME/.config/nvim/gogo/finger/deo-echodoc.vim

"----------------fix_deoplete
" source $HOME/.config/nvim/gogo/finger/fix_deoplete_in_cursors.vim

luafile $HOME/.config/nvim/lua/Plug/fzf.lua
luafile $HOME/.config/nvim/lua/Plug/clorizer.lua
luafile $HOME/.config/nvim/lua/Plug/goyo.lua
" source $HOME/.config/nvim/gogo/brain/fzf.vim
" source $HOME/.config/nvim/gogo/brain/neomake.vim
" source $HOME/.config/nvim/gogo/brain/ale.vim

source $HOME/.config/nvim/Plug/lightLine2.vim
"source $HOME/.config/nvim/gogo/hands/openbrowser_rc.vim


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

