#!/usr/sh

# back to file
cp $HOME/.vimrc $HOME/git/vag_setup/setup/
cp $HOME/.tmux.conf $HOME/git/vag_setup/setup
cp $HOME/.zshrc $HOME/git/vag_setup/setup 
cp $HOME/.curlrc $HOME/git/vag_setup/setup

# bak vim-packge
cp $HOME/.config/nvim/.vimrc $HOME/git/vag_setup/setup/.config/nvim/
cp $HOME/.config/nvim/init.vim $HOME/git/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/gogo/ $HOME/git/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/function/ $HOME/git/vag_setup/setup/.config/nvim/
cp -r $HOME/.config/nvim/colors $HOME/git/vag_setup/setup/.config/nvim/

# config package
cp 

#Up
cd $HOME/git/vag_setup/ 
git add . 
git commit -m 'autobakup' 
git pull origin main 
git push -u origin main 

