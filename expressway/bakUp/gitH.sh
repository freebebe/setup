#home_vim*1 tmux*1
cp ~/.vimrc ~/git/system/setup/linux/ 
cp ~/.tmux.conf ~/git/system/setup/linux/ && cp ~/.tmux.powerline.conf ~/git/system/setup/linux/ 
cp ~/.Xmodmap ~/git/system/setup/linux/
cp ~/.gitconfig ~/git/system/setup/linux
#filepacker ->  /home/.config/
##-rf && r : skip question
cp -r ~/.config/Code/User/ ~/git/system/setup/linux/.config/Code
cp -r ~/.config/fish/ ~/git/system/setup/linux/.config
cp -r ~/.config/zathura/ ~/git/system/setup/linux/.config
cp -r ~/.config/rclone/ ~/git/system/setup/linux/.config
cp -r ~/.config/i3/ ~/git/system/setup/linux/.config
cp -r ~/.config/autostart/ ~/git/system/setup/linux/.config
cp -r ~/.config/nvim/ ~/git/system/setup/linux/.config
#
# #filepacker ->  /home/
# cp -r ~/bkup/ ~/git/system/setup/
cp -r ~/expressway/ ~/git/system/setup/
#
# #upgrade_to_git_packge
cd ~/git/system/setup/

git add . 
git commit -m 'auto_time_line'
git pull origin master
git push -u origin master
#
