# i3 miX plasma(kde)

```
# Plasma Integration
## Try to kill the wallpaper set by Plasma (it takes up the entire workspace and hides everythiing)
exec --no-startup-id wmctrl -c Plasma
for_window [title="Desktop — Plasma"] kill, floating enable, border none
for_window [title="Bureau — Plasma"] kill, floating enable, border none

## Avoid tiling popups, dropdown windows from plasma
## for the first time, manually resize them, i3 will remember the setting for floating windows
for_window [class="plasmashell"] floating enable
for_window [class="Plasma"] floating enable, border none
for_window [title="plasma-desktop"] floating enable, border none
for_window [title="win7"] floating enable, border none
for_window [class="krunner"] floating enable, border none
for_window [class="Kmix"] floating enable, border none
for_window [class="Klipper"] floating enable, border none
for_window [class="Plasmoidviewer"] floating enable, border none
```
> pull in '$HOME/.config/i3/config'

```
# Disable KWin and use i3gaps as WM
export KDEWM=/usr/bin/i3

# Start picom as compositor
picom --config ~/.config/picom.conf
```
> pull in '$HOME/.config/plasma-workspace/env/wm.sh'
