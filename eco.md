default-bascs
==========
```
sudo apt install vim curl wget aria2 tree tmux bspwm dmenu thefuck Firejail Fail2ban python3 python3-dev python3-pip python3-setuptools fail2ban eog
```


 <strong>ranger-setup--config-edtior</strong>
 >指定默认编辑器
 (ubuntu默认为nano)
```
        sudo update-alternatives --config editor
```
* 3   /usr/bin/vim.basic --> 完整版vim
* 4   /usr/bin/vim.tiny  -->  残版vim
                
        

third-bascs
-------------
polybar

theFuck
sudo pip3 install thefuck

settingup
========

wifi
------------
```
  sudo service network-manager restart
  nmcli dev wifi list
  nmcli dev wifi con 'SSID' password 'wifi-passwd'
```
