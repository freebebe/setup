## install xwayland
pacman -S xorg   >>     Numb-45     >>  xorg-xwayland

## update_driver [fwupd]
pacman -S fwupd


# for first start
```
sudo systemctl enable --now reflector.timer
sudo systmctl enable --now fstrim.timer

sudo systemctl enable tlp.service
sudo systemctl start tlp.service

sudo systemctl mask systemd-rfkill.service
sudo systemctl mask systemd-rfkill-socket
```


`systemctl start`, `systemctl stop`: starts (stops) the unit in question immediately;
`systemctl enable`, `systemctl disable`: marks (unmarks) the unit for autostart at boot time (in a unit-specific manner, described in its [Install] section);
`systemctl mask`, `systemctl unmask`: disallows (allows) all and any attempts to start the unit in question (either manually or as a dependency of any other unit, including the dependencies of the default boot target). Note that marking for autostart in systemd is implemented by adding an artificial dependency from the default boot target to the unit in question, so "mask" also disallows autostarting.

