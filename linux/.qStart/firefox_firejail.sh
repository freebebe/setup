#!/bin/bash
#______________________________________________________________________________
#                                                                   sway-wayland
MOZ_ENABLE_WAYLAND=1

#______________________________________________________________________________
#                                                                           ibus
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=xim

# firejail --dns=8.8.8.8 --x11=xorg firefox
firejail --seccomp --nonewprivs --private-tmp firefox
