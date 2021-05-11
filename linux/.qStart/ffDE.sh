#!/bin/sh

# firejail --dns=8.8.8.8 --x11=xorg firefox
cd /opt/ffDE/firefox/
firejail --seccomp --nonewprivs --private-tmp ./firefox
cd
