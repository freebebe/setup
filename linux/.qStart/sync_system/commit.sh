#!/usr/bin/bash

#   software upgrading
sudo apt install vim curl wget aria2 tree tmux python3 python3-dev python3-pip python3-gpg python3-setuptools fish fzf rclone ranger fonts-font-awesome ruby-full ruby-sass proxychains

#   date background
mkdir setup && cd setup
git clone https://github.com/freebebe/setup.git

#
cd setup && cd linux
cp .vimrc ~/ && cp .tmux.conf ~/ && cp .tmux.powerline.conf ~/

