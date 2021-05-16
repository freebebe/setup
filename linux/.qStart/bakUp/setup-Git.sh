#!/bin/sh

#home_vim*1 tmux*1 zsh*1 Xmodmap*1
cp $HOME/.vimrc $HOME/Documents/git/system/setup/linux
cp $HOME/.tmux.conf $HOME/Documents/git/system/setup/linux
cp $HOME/.Xmodmap $HOME/Documents/git/system/setup/linux
cp $HOME/.gitconfig $HOME/Documents/git/system/setup/linux
cp $HOME/.zshrc $HOME/Documents/git/system/setup/linux
cp $HOME/.curlrc $HOME/Documents/git/system/setup/linux
cp $HOME/.profile $HOME/Documents/git/system/setup/linux
#filepacker ->  /home/.config/
##-rf && r : skip question
cp -r $HOME/.config/Code/User/ $HOME/Documents/git/system/setup/linux/.config/Code
cp -r $HOME/.config/zathura/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/rclone/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/i3/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/sway/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/i3status/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/autostart/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/nvim/ $HOME/Documents/git/system/setup/linux/.config
cp -r $HOME/.config/kitty/ $HOME/Documents/git/system/setup/linux/.config

## brower
cp -r $HOME/.mozilla/firefox/l0gvz3le.default-release/prefs.js $HOME/Documents/git/system/setup/linux/
## for ubuntu-desk-i3
cp -r $HOME/.config/gtk-3.0/ $HOME/Documents/git/system/setup/ubuntuDesktop/.config
cp -r $HOME/.Xresources $HOME/Documents/git/system/setup/ubuntuDesktop/

# #filepacker ->  /home/
# cp -r $HOME/bkup/ $HOME/Documents/git/system/setup/
cp -r $HOME/.qStart $HOME/Documents/git/system/setup/linux
#
# #upgrade_to_git_packge
cd $HOME/Documents/git/system/setup/
git add .
git commit -m 'up'
git pull origin master
# git pull origin main
git push -u origin master
# git push -u origin main
#
cd
