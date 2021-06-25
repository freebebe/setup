#!/bin/sh

#home_vim*1 tmux*1 zsh*1 Xmodmap*1
cp $HOME/.vimrc $HOME/one/setup/linux
cp $HOME/.tmux.conf $HOME/one/setup/linux
cp $HOME/.Xmodmap $HOME/one/setup/linux
cp $HOME/.gitconfig $HOME/one/setup/linux
cp $HOME/.zshrc $HOME/one/setup/linux
cp $HOME/.curlrc $HOME/one/setup/linux
cp $HOME/.profile $HOME/one/setup/linux
cp $HOME/.pam_environment $HOME/one/setup/linux
cp $HOME/.Xdefaults $HOME/one/setup/linux              # wayland
cp $HOME/.Xresources $HOME/one/setup/linux             # x10

#filepacker ->  /home/.config/
##-rf && r : skip question
cp -r $HOME/.config/Code/User/ $HOME/one/setup/linux/.config/Code
cp -r $HOME/.config/zathura/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/i3/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/sway/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/i3status/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/nvim/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/kitty/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/gtk-3.0/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/environment.d/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/aria2/ $HOME/one/setup/linux/.config
cp -r $HOME/.config/alacritty/ $HOME/one/setup/linux/.config

## brower
cp -r $HOME/.mozilla/firefox/l0gvz3le.default-release/prefs.js $HOME/one/setup/linux/

## V3
cp /opt/vw/config.json $HOME/one/setup/linux/bkup

## for ubuntu-desk-i3
cp -r $HOME/.Xresources $HOME/one/setup/ubuntuDesktop/

# #filepacker ->  /home/
# cp -r $HOME/bkup/ $HOME/one/setup/
cp -r $HOME/log/ $HOME/one/setup/archDesktop/
cp -r $HOME/.qStart $HOME/one/setup/linux
#
# to flash

# #upgrade_to_git_packge
cd $HOME/one/setup/
git add .
git commit -m 'up'
git pull origin master
# git pull origin main
git push -u origin master
# git push -u origin main
#
exit 0
