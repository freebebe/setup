#!/usr/sh

# back to file
cp $HOME/.vimrc $HOME/Documents/git/system/vag_setup/setup/
cp $HOME/.tmux.conf $HOME/Documents/git/system/vag_setup/setup
cp $HOME/.zshrc $HOME/Documents/git/system/vag_setup/setup 
cp $HOME/.curlrc $HOME/Documents/git/system/vag_setup/setup

# bak vim-packge
cp $HOME/.config/nvim/.vimrc $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp $HOME/.config/nvim/init.vim $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/gogo/ $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/function/ $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/colors $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/lua $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/snippets $HOME/Documents/git/system/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/dict $HOME/Documents/git/system/vag_setup/setup/.config/nvim/

# config package
cp -r $HOME/.config/aria2 $HOME/Documents/git/system/vag_setup/setup/.config/nvim/

#Up
cd $HOME/Documents/git/vag_setup/ 
git add . 
git commit -m 'autobakup' 
git pull origin main 
git push -u origin main 

exit 0
