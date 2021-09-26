#!/usr/bin/env bash

set -euo pipefail
(exec bwrap \
      --ro-bind "/usr/share" "/usr/share" \
      --ro-bind "/usr/lib" "/usr/lib" \
      --ro-bind "/usr/lib64" "/usr/lib64" \
      --symlink ../tmp var/tmp \
      --proc /proc \
      --dev /dev \
      --tmpfs "/tmp" \
      --tmpfs "/run" \
      --tmpfs "/usr/lib/modules" \
      --tmpfs "/usr/lib/systemd" \
      --symlink "usr/lib" "/lib" \
      --symlink "usr/lib64" "/lib64" \
      --symlink "usr/bin" "/bin" \
      --symlink "usr/sbin" "/sbin" \
      --ro-bind "/usr/bin" "/usr/bin" \
      --ro-bind "/etc/resolv.conf" "/etc/resolv.conf" \
      --ro-bind "/etc/ssl" "/etc/ssl" \
      --ro-bind "/etc/fonts" "/etc/fonts" \
      --ro-bind "/etc/ca-certificates" "/etc/ca-certificates" \
      --ro-bind "$HOME/.config/yarn/global" "/home/ZE/.config/yarn/global" \
      --ro-bind "$HOME/.nvim/plugged" "/home/ZE/.nvim/plugged" \
      --ro-bind "$HOME/box/.zshrc" "/home/ZE/.zshrc" \
      --ro-bind "$HOME/box/.tmux.conf" "/home/ZE/.tmux.conf" \
      --ro-bind "$HOME/box/.yarn" "/home/ZE/.yarn" \
      --ro-bind "$HOME/box/.local/share/nvim/site/autoload" "/home/ZE/.local/share/nvim/site/autoload" \
      --ro-bind "$HOME/box/.local/share/nvim/rplugin.vim" "/home/ZE/.local/share/nvim/rplugin.vim" \
      --ro-bind "$HOME/box/machine-id" "/etc/machine-id" \
      --bind "$HOME/test" "/home/ZE/uat" \
      --bind "$HOME/project" "/home/ZE/test/tmo" \
      --bind "$HOME/.config/nvim" "/home/ZE/.config/nvim" 
      --unshare-all \
      --share-net \
      --die-with-parent \
      --dir /run/user/$(id -u) \
      --hostname ZE \
      --setenv "HOME" "/home/ZE" \
      --setenv "USER" "/home/ZE" \
      --setenv "LOGNAME" "/home/ZE" \
      --setenv "XDG_RUNTIME_DIR" "/run/user/`id -u`" \
      --setenv "PS1" "noFish$ " \
      --file 11 "/etc/passwd" \
      --file 12 "/etc/group" \
      /bin/sh) \
    11< <(getent passwd $UID 65534) \
    12< <(getent group $(id -g) 65534) \
