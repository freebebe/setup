#!/usr/bin/env bash

set -euo pipefail
(exec bwrap \
  --ro-bind "/usr/share" "/usr/share" \
  --ro-bind "/usr/lib" "/usr/lib" \
  --ro-bind "/usr/lib64" "/usr/lib64" \
  --tmpfs "/usr/lib/modules" \
  --tmpfs "/usr/lib/systemd" \
  --symlink "/usr/lib" "/lib" \
  --symlink "/usr/lib64" "/lib64" \
  --ro-bind "/usr/bin" "/usr/bin" \
  --symlink "/usr/bin" "/bin" \
  --symlink "/usr/bin" "/sbin" \
  --setenv "/usr/bin" "/usr/bin" \
  --ro-bind "/etc/fonts" "/etc/fonts" \
  --ro-bind "/etc/resolv.conf" "/etc/resolv.conf" \
  --ro-bind "/etc/ssl" "/etc/ssl" \
  --ro-bind "/etc/ca-certificates" "/etc/ca-certificates" \
  --ro-bind "/etc/localtime" "/etc/localtime" \
  --ro-bind "$HOME/.config/yarn/global" "/home/ZE/.config/yarn/global" \
  --ro-bind "$HOME/.nvim/plugged" "/home/ZE/.nvim/plugged" \
  --ro-bind "$HOME/box/.zshrc" "/home/ZE/.zshrc" \
  --ro-bind "$HOME/box/.tmux.conf" "/home/ZE/.tmux.conf" \
  --ro-bind "$HOME/box/.yarn" "/home/ZE/.yarn" \
  --ro-bind "$HOME/box/.local/share/nvim/site/autoload" "/home/ZE/.local/share/nvim/site/autoload" \
  --ro-bind "$HOME/box/machine-id" "/etc/machine-id" \
  --bind "$HOME/box/.local/share/nvim/rplugin.vim" "/home/ZE/.local/share/nvim/rplugin.vim" \
  --proc "/proc" \
  --dev "/dev" \
  --tmpfs "/tmp" \
  --tmpfs "/run" \
  --unsetenv "DBUS_SESSION_BUS_ADDRESS" \
  --setenv "HOME" "/home/ZE" \
  --setenv "USER" "/home/ZE" \
  --setenv "LOGNAME" "/home/ZE" \
  --bind "$HOME/test" "/home/ZE/uat" \
  --bind "$HOME/project" "/home/ZE/test/tmo" \
  --bind "$HOME/.config/nvim" "/home/ZE/.config/nvim" \
  --hostname "dq-999" \
  --unshare-all \
/bin/sh) \
11< <(getent passwd $UID 65534) \
12< <(getent group $(id -g) 65534) \

