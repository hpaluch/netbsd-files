#!/bin/sh
set -xeuo pipefail
pkgin install curl mc lynx vim btop ncdu git-base git-lfs pinfo
# safe: create vimrc
[ -f /usr/pkg/etc/vimrc ] || echo 'set background=dark' > /usr/pkg/etc/vimrc
exit 0
