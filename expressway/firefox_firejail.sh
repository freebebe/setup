#!/bin/sh

# firejail --dns=8.8.8.8 --x11=xorg firefox
firejail --seccomp --nonewprivs --private-tmp firefox
