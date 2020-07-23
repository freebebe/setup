# setup

default-bascs
==========
```
sudo apt update && apt upgrade
sudo apt install vim curl wget aria2 tree tmux thefuck python3 python3-dev python3-pip python3-setuptools eog tlp ruby-full ruby-sass net-tools zathura psensor ncdu
sudo apt install -y fonts-font-awesome 

third-tools
```
sudo apt install firejail
sudo apt install fail2ban
```
```
wm-install
```
sudo apt update && apt upgrade
sudo apt install bspwm dmenu xsecurelock xss-lock xfce4-terminal thunar 
```

 <strong>lockscreen-xsecurelock</strong>
```
xset s 300 5
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
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

tlp-code
=========

Check for running tlp : sudo systemctl status tlp
System info : sudo tlp-stat -s
PCI info : sudo tlp-pcilist
USB info :  sudo tlp-usblist
Show config :  : sudo tlp-stat -c
Show everything : sudo tlp-stat 
Show thermal info : sudo tlp-stat -t
Show processor info : sudo tlp-stat -p
Show battery info : sudo tlp-stat -b
Show refreshing battery info : watch sudo tlp-stat -b

handleLidSwitch-setup
==============

HandleLidSwitch=suspend		#stop
HandleLidSwitch=hibernate		#sleep

