# 1
The autostart file from hplip-gui is located in /etc/xdg/autostart/hplip-systray.desktop.

To *fix the menu display* we need to launch hplip with help of DBus (as in DropBox case) by creating a custom copy of this file for the user:

```
killall hp-systray
rm ~/.hplip/hp-systray.lock
mkdir -p ~/.config/autostart/
cp /etc/xdg/autostart/hplip-systray.desktop ~/.config/autostart/
sed -i "s/hp-systray -x/dbus-launch hp-systray -x/" ~/.config/autostart/hplip-systray.desktop
```

# 2
If you don't want to remove it, changing its extension also works, for example extension old: 

`/etc/xdg/autostart/hplip-systray.desktop.old`
