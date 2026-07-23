#!/bin/sh
# setup binary package for NetBSD stable
set -euo pipefail

errx () { echo "ERROR: $*" >&2; exit 1; }

has_wheel=
# we must be in group wheel
for i in `groups`; do
	[ "$i" != wheel ] || {
		has_wheel=1
		break
	}
done
[ -n "$has_wheel" ] || errx "Sorry, you must be member of group 'wheel'"

PKG_PATH="https://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/$(uname -p)/$(uname -r|cut -f '1 2' -d.|cut -f 1 -d_)/All"
export PKG_PATH

# we have to use "su" before "doas" is installed and configured
set -x
[ -x /usr/pkg/bin/doas ] || su root -c "pkg_add doas"
[ -d /usr/pkg/etc ] || su root -c "mkdir -p /usr/pkg/etc"
[ -f /usr/pkg/etc/doas.conf ] || echo "permit nopass setenv { PKG_PATH } :wheel"  | su root -c "tee /usr/pkg/etc/doas.conf"
# now we should be able to use doas without password
doas id

# install necessary packages
[ -x /usr/pkg/bin/ncdu ] || doas -n pkg_add git-base git-lfs vim mc ncdu
# setup dark vim background
[ -f /usr/pkg/etc/vimrc ] || echo 'set background=dark' | doas -n tee /usr/pkg/etc/vimrc


exit 0
