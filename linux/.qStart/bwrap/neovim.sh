#!/usr/bin/env bash
set -euo pipefail
(exec bwrap \
      --ro-bind /usr /usr \
      --dir /tmp \
      --dir /var \
      --symlink ../tmp var/tmp \
      --proc /proc \
      --dev /dev \
      --ro-bind /etc/resolv.conf /etc/resolv.conf \
      --symlink usr/lib /lib \
      --symlink usr/lib64 /lib64 \
      --symlink usr/bin /bin \
      --symlink usr/sbin /sbin \
      --ro-bind /usr/bin /usr/bin \
      --bind $HOME/.config/nvim /home/ZE/.config/nvim \
      --ro-bind $HOME/.config/yarn/global /home/ZE/.config/yarn/global \
      --ro-bind $HOME/.nvim/plugged /home/ZE/.nvim/plugged \
      --ro-bind $HOME/.zshrc /home/ZE/.zshrc \
      --ro-bind $HOME/.tmux.conf /home/ZE/.tmux.conf \
      --ro-bind $HOME/.local/share/nvim/site/autoload /home/ZE/.local/share/nvim/site/autoload \
      --ro-bind $HOME/.local/share/nvim/rplugin.vim /home/ZE/.local/share/nvim/rplugin.vim \
      --ro-bind $HOME/box/machine-id /etc/machine-id \
      --bind $HOME/test /home/ZE/test \
      --chdir / \
      --unshare-all \
      --share-net \
      --die-with-parent \
      --dir /run/user/$(id -u) \
      --hostname ZE \
      --setenv HOME /home/ZE \
      --setenv XDG_RUNTIME_DIR "/run/user/`id -u`" \
      --setenv PS1 "noFish$ " \
      --file 11 /etc/passwd \
      --file 12 /etc/group \
      /bin/sh) \
    11< <(getent passwd $UID 65534) \
    12< <(getent group $(id -g) 65534) \
