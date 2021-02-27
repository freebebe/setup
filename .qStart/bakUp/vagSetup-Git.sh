#back to file
cp ~/.vimrc ~/git/vag_setup/setup/
cp ~/.tmux.conf ~/git/vag_setup/setup
cp ~/.zshrc ~/git/vag_setup/setup 
cp ~/.curlrc ~/git/vag_setup/setup

#bak packge
cp ~/.config/nvim/.vimrc ~/git/vag_setup/setup/.config/nvim/
cp ~/.config/nvim/init.vim ~/git/vag_setup/setup/.config/nvim/
cp -r ~/.config/nvim/gogo/ ~/git/vag_setup/setup/.config/nvim/
cp -r ~/.config/nvim/colors ~/git/vag_setup/setup/.config/nvim/

#Up
cd ~/git/vag_setup/
git add .
git commit -m 'autobakup'
git pull origin main
git push -u origin main

