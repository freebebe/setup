export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=xim

bwrap \
--symlink usr/lib /lib \
--symlink usr/lib64 /lib64 \
--symlink /sys/dev/char /sys/dev/char \
--symlink /sys/devices/pci0000:00 /sys/devices/pci0000:00 \
--ro-bind /usr/lib /usr/lib \
--ro-bind /usr/lib64 /usr/lib64 \
# --ro-bind /opt/firefox /opt/firefox \
# --symlink /opt/firefox/firefox /usr/bin/firefox \
# --ro-bind /usr/bin/transmission-gtk /usr/bin/transmission-gtk \
# --ro-bind /usr/share/applications /usr/share/applications \
# --ro-bind /usr/share/ca-certificates /usr/share/ca-certificates \
# --ro-bind /usr/share/fonts /usr/share/fonts \
# --ro-bind /usr/share/glib-2.0 /usr/share/glib-2.0 \
# --ro-bind /usr/share/glvnd /usr/share/glvnd \
# --ro-bind /usr/share/icons /usr/share/icons \
# --ro-bind /usr/share/libdrm /usr/share/libdrm \
# --ro-bind /usr/share/mime /usr/share/mime \
# --ro-bind /usr/share/X11/xkb /usr/share/X11/xkb \
# --ro-bind /usr/share/icons /usr/share/icons \
# --ro-bind /usr/share/mime /usr/share/mime \
# --ro-bind /etc/fonts /etc/fonts \
# --ro-bind /etc/machine-id /etc/machine-id \
# --ro-bind /etc/resolv.conf /etc/resolv.conf \
# --dir /run/user/"$(id -u)" \
# --dev /dev \
# --dev-bind /dev/dri /dev/dri \
# --ro-bind /sys/dev/char /sys/dev/char \
# --ro-bind /sys/devices/pci0000:00 /sys/devices/pci0000:00 \
# --proc /proc \
# --tmpfs /tmp \
# --bind /home/example/.mozilla /home/example/.mozilla \
# --bind /home/example/.config/transmission /home/example/.config/transmission \
# --bind /home/example/Downloads /home/example/Downloads \
# --unshare-all \
# --share-net \
# --hostname vxzw \
# --setenv HOME /home/example \
# --setenv GTK_THEME Adwaita:dark \
# --setenv MOZ_ENABLE_WAYLAND 1 \
# --setenv PATH /usr/bin \
# --die-with-parent \
# --new-session \
/usr/bin/firefox
