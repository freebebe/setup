!/usr/bin/env bash
set -euo pipefail
(
    exec bwrap \
     --ro-bind /usr/bin/ /usr/bin/ \
     --ro-bind /usr/share /usr/share \
     --ro-bind /usr/lib /usr/lib \
     --ro-bind /usr/lib64 /usr/lib64 \
     --symlink /usr/lib64 /lib64 \
     --proc /proc \
     --dev /dev \
     --ro-bind "${@: -1}" ~/"$(basename "${@: -1}")" \
     --unshare-user \
     --unshare-pid \
     --unshare-net \
     --unshare-uts \
     --unshare-cgroup \
     --new-session \
     --seccomp 10 \
     /usr/bin/feh "$@"
)
