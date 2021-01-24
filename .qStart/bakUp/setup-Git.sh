#home_vim*1 tmux*1 zsh*1 Xmodmap*1
cp ~/.vimrc ~/git/system/setup/linux 
cp ~/.tmux.conf ~/git/system/setup/linux/ 
cp ~/.Xmodmap ~/git/system/setup/linux
cp ~/.gitconfig ~/git/system/setup/linux
cp ~/.zshrc ~/git/system/setup/linux
cp ~/.curl ~/git/system/setup/linux
#filepacker ->  /home/.config/
##-rf && r : skip question
cp -r ~/.config/Code/User/ ~/git/system/setup/linux/.config/Code
cp -r ~/.config/zathura/ ~/git/system/setup/linux/.config
cp -r ~/.config/rclone/ ~/git/system/setup/linux/.config
cp -r ~/.config/i3/ ~/git/system/setup/linux/.config
cp -r ~/.config/i3status/ ~/git/system/setup/linux/.config
cp -r ~/.config/autostart/ ~/git/system/setup/linux/.config
cp -r ~/.config/nvim/ ~/git/system/setup/linux/.config
cp -r ~/.config/kitty/ ~/git/system/setup/linux/.config

# #filepacker ->  /home/
# cp -r ~/bkup/ ~/git/system/setup/
cp -r ~/.qStart ~/git/system/setup/
#
# #upgrade_to_git_packge
cd ~/git/system/setup/

git add . 
git commit -m 'auto_time_line'
git pull origin master
# git pull origin main
git push -u origin master
# git push -u origin main
#
cd
