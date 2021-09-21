#!/usr/bin/env bash
set -euo pipefail
(
    exec bwrap \
     --ro-bind /usr/bin/mpv /usr/bin/mpv \
     --ro-bind /usr/share /usr/share \
     --ro-bind /usr/lib /usr/lib \
     --ro-bind /usr/lib64 /usr/lib64 \
     --symlink /usr/lib64 /lib64 \
     --symlink /usr/bin /bin \
     --proc /proc \
     --dev-bind /dev /dev \
     --ro-bind /tmp/.X11-unix /tmp/.X11-unix \
     --ro-bind /etc /etc \
     --ro-bind ~/.config/mpv ~/.config/mpv \
     --ro-bind "${@: -1}" ~/"$(basename "${@: -1}")" \
     --chdir ~/ \
     --unsetenv DBUS_SESSION_BUS_ADDRESS \
     --unshare-user-try \
     --unshare-pid \
     --unshare-net \
     --unshare-uts \
     --unshare-cgroup-try \
     --new-session \
     --seccomp 10 \
     /usr/bin/mpv "$(basename "${@: -1}")"
)

# warning: still uses read-only X11 socket
