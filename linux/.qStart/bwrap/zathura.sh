#!/usr/bin/env bash
set -euo pipefail
(
    exec bwrap \
     --symlink usr/bin /bin \
     --ro-bind /usr/bin/zathura /usr/bin/zathura \
     --ro-bind /usr/share /usr/share \
     --ro-bind /usr/lib /usr/lib \
     --ro-bind /usr/lib64 /usr/lib64 \
     --proc /proc \
     --ro-bind /etc/fonts /etc/fonts \
     --ro-bind $HOME/.config/zathura /home/ZE/.config/zathura \
     --ro-bind $HOME/.cache/fontconfig /home/ZE/.cache/fontconfig \
     --ro-bind $HOME/box/pdf /home/ZE/mailBox \
     --ro-bind "${@: -1}" ~/"$(basename "${@: -1}")" \
     --chdir ~/ \
     --unsetenv DBUS_SESSION_BUS_ADDRESS \
     --hostname ZE \
     --setenv HOME /home/ZE \
     --unshare-all \
     --new-session \
     --seccomp 10 \
     /usr/bin/zathura --config-dir=~/.config/zathura/ "$(basename "${@: -1}")"
)
