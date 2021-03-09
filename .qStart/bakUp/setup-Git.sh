#!/bin/sh

#home_vim*1 tmux*1 zsh*1 Xmodmap*1
cp $HOME/.vimrc $HOME/git/system/setup/linux 
cp $HOME/.tmux.conf $HOME/git/system/setup/linux/ 
cp $HOME/.Xmodmap $HOME/git/system/setup/linux
cp $HOME/.gitconfig $HOME/git/system/setup/linux
cp $HOME/.zshrc $HOME/git/system/setup/linux
cp $HOME/.curl $HOME/git/system/setup/linux
#filepacker ->  /home/.config/
##-rf && r : skip question
cp -r $HOME/.config/Code/User/ $HOME/git/system/setup/linux/.config/Code
cp -r $HOME/.config/zathura/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/rclone/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/i3/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/i3status/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/autostart/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/nvim/ $HOME/git/system/setup/linux/.config
cp -r $HOME/.config/kitty/ $HOME/git/system/setup/linux/.config

# #filepacker ->  /home/
# cp -r $HOME/bkup/ $HOME/git/system/setup/
cp -r $HOME/.qStart $HOME/git/system/setup/
#
# #upgrade_to_git_packge
cd $HOME/git/system/setup/ 
git add .  
git commit -m 'up' 
git pull origin master 
# git pull origin main
git push -u origin master 
# git push -u origin main
#
cd
