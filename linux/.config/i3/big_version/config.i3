#_______________________________________________________________________________
#                                                                       unkwon{{{
    workspace_auto_back_and_forth yes
    force_display_urgency_hint 0 ms
    focus_on_window_activation urgent

    floating_minimum_size -1 x -1
    floating_maximum_size -1 x -1

    # xautolock -time 5 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off' &
    # xautolock -time 7 -locker "systemctl suspend" &

    font pango: Tamzen 11

    # background
    exec --no-startup-id feh --bg-fill $HOME/Pictures/background/lightBlue.png


#____________________________________________________________________________}}}

#_______________________________________________________________________________
#                                                           Layout key stuff{{{

# reload the configuration file
    bindsym $mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart
# exit i3 (logs you out of your X session)
    bindsym $mod+shift+q exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

# choose xrandr displaymode
    bindsym $mod+Shift+Ctrl+p mode "$mode_display"
    set $mode_display Display mode (d) dualRight, (h) HDMI, (l) laptop
    mode "$mode_display" {
        bindsym d exec --no-startup-id sh $HOME/.config/i3/screenlayouts/display dualRight, mode "default"
        bindsym m exec --no-startup-id sh $HOME/.config/i3/screenlayouts/display HDMI, mode "default"
        bindsym l exec --no-startup-id sh $HOME/.config/i3/screenlayouts/display laptop, mode "default"

        # back to normal: Enter or Escape
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }

#____________________________________________________________________________}}}

#_______________________________________________________________________________
#                                                               applications{{{

#_____________________________/autoStart
    exec --no-startup-id nm-applet
    exec --no-startup-id blueman-applet
    # exec --no-startup-id clipit                       #copy_data
    # exec_always xfce4-power-manager
    exec_always --no-startup-id xfce4-power-manager
    # exec --no-startup-id /usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil

    # exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    # exec --no-startup-id nitrogen --restore; sleep 1; compton -b            # background-image chenage for fee time
    # exec --no-startup-id xpad
    # exec --no-startup-id dropbox
    exec --no-startup-id dropbox stop && dbus-launch dropbox start -i
    exec --no-startup-id flameshot              # face_your_screen_face
    # exec --no-startup-id i3-confg-wizard
    # exec_always dropbox
    # exec --no-startup-id conky
    # exec --no-startup-id volumeicon
    exec --no-startup-id dunst                  # Notification

    # lockscreen
    # exec_always --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
    # exec_always --no-startup-id xss-lock --transfer-sleep-lock -- xsecurelock --nofork
    # exec_always --no-startup-id xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock -- xset dpms 333 555
    exec_always --no-startup-id xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock

    # exec --no-startup-id xset dpms 365 1357 6789
    # exec --no-startup-id xset dpms 365 1357
    # exec_always --no-startup-id xss-lock --transfer-sleep-lock -- xsecurelock 
    # exec_always --no-startup-id xss-lock -n /usr/lib/xsecurelock/dimmer -l -- xsecurelock
    # exec_always --no-startup-id xautolock -time 553 -locker fuzzy_lock -notify 20 -notifier 'xset dpms force off' &
    # exec_always --no-startup-id xautolock -time 555 -locker "systemctl suspend" &

    # exec --no-startup-id xmodmap $HOME/.Xmodmap
    exec_always xmodmap $HOME/.Xmodmap
    exec --no-startup-id $HOME/.config/i3/screenlayouts/externalRight.sh
    # exec $HOME/.config/i3/tools/ACorPOWER.sh

    # touch pad speed
    exec --no-startup-id  xinput set-prop 16 'libinput Accel Speed' 0.5 

# ///////////////////////////////////////////////////////////////////////////////////////////////////////
#_____________________________/App_Key
# launch categorized menu
    bindsym $mod+z exec --no-startup-id morc_menu

# GUI file manager -- thunar
    bindsym $mod+e exec --no-startup-id dolphin

# ranger with konsole
# bindsym $mod+Shift+e konsole -e ranger
# image_key
    bindsym $mod+w exec --no-startup-id flameshot gui    #flameshot
#
    # bindsym $mod+alt+t exec --no-startup-id compton -b
# drop down terminal
    # bindsym $mod+Return exec --no-startup-id yakuake
# WMonky
    # bindsym $mod+F6 exec /opt/writemonkey3/nw
# firefox
    bindsym $mod+F2 exec --no-startup-id $HOME/.qStart/firefox_firejail.sh
# dmenu(backup) 
# bindsym $mod+Ctrl+b exec terminal -e 'bmenu'
# kill_GUI
    bindsym $mod+Ctrl+x --release exec --no-startup-id xkill
# xpad
    bindsym $mod+F1 exec --no-startup-id xpad -t -N
# ranger->file
    # bindsym $mod+F4 exec thunar path/to/Documents/uni2019-20
    # bindsym $mod+F1 exec thunar ~/Downloads

# lock screen
    bindsym $mod+l exec --no-startup-id xsecurelock

# sleep
    # bindsym $mod+F12 exec --no-startup-id $HOME/.config/i3/tools/sleep.sh
# external screen

# both
    # bindsym $mod+Shift+b exec --no-startup-id $HOME/.config/i3/screenlayouts/externalRight.sh
#my
    # bindsym $mod+Shift+m exec --no-startup-id $HOME/.config/i3/screenlayouts/only.sh
#only ext
    # bindsym $mod+Shift+n exec --no-startup-id $HOME/.config/i3/screenlayouts/only_top.sh

#____________________________________________________________________________}}}



#_______________________________________________________________________________
#                                                                       bar{{{
# theme colors
#   class                   border | backgr | text | indicator
    client.focused         #383838  #383838  #CCCCCC #2ECC71
    client.unfocused       #16404B  #16404B  #2ECC71 #222222
    client.urgent          #274D01  #900000  #FFFFFF #900000

#____________________________________________________________________________}}}
