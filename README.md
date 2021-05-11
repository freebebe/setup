# setup

default-bascs
==========
```
sudo apt update && apt upgrade -y
sudo apt install neovim vim curl wget aria2 tree tmux python3 python3-dev python3-pip pipx python3-gpg python3-setuptools eog tlp net-tools zathura psensor ncdu fonts-font-awesome preload ranger uget flameshot xfburn wmctrl fzf rclone testdisk shellcheck qrencode peek proxychains4 dolphin firejail lnav pandoc httpie vagrant entr playerctl kdenlive gpick xournal rustc golang rbenv newsboat universal-ctags xtitle xbacklight keepassxc libinput-tools pavucontrol -y

```
```
sudo apt install fail2ban
sudo apt install texlive-full
```

## image && icon && video
```
sudo apt install gimp -y
sudo apt install inkscape -y
sudo apt install blender -y
```
```
wm-install
```
sudo apt update && apt upgrade
sudo apt install bspwm i3 dmenu rofi xsecurelock xss-lock terminator thunar blueman pm-utils xfce4-notifyd xfce4-power-manager

/*for_touchpad*/
sudo apt install sy***(version && -dev)

```

pandoc -> .doc等文档转译

 <strong>lockscreen-xsecurelock</strong>

```
xset s 300 5
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
```

#sys manage (for_gnome_blackscreen)
###cpu
  只针对intel处理器中SandyBridge（含IvyBridge）及更新的构架的CPU。intel构架列表：List of Intel CPU microarchitectures。援引：
  ```
  sudo vim /etc/default/grub
  ```
  ```
  GRUB_CMDLINE_LINUX_DEFAULT=”quiet” ---> GRUB_CMDLINE_LINUX_DEFAULT=”quiet intel_pstate=enable”
  ```
  然后执行sudo grub-mkconfig -o /boot/grub/grub.cfg ，重启生效。
  检查：执行cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver，如果显示intel_pstate则表示启用成功，否则是未启用成功或不支持该功能。


 **ranger-setup--config-edtior**
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

->theFuck
`pip3 install thefuck`

settingup
========

wifi
------------
```
  sudo service network-manager restart
  nmcli dev wifi list
  nmcli dev wifi con 'SSID' password 'wifi-passwd'
```

~~~
###problem is 
~~~
dbus-hal 
~~~

```
sudo /etc/init.d/acpid restart
```
