#!/bin/sh
# setup pkgsrc for CURRENT
set -xeuo pipefail

BASEDIR=$HOME

TARBALL=pkgsrc.tar.gz

[ -f "$BASEDIR/$TARBALL" ] || ( cd $BASEDIR &&  ftp https://cdn.netbsd.org/pub/pkgsrc/current/$TARBALL )
[ -d "$BASEDIR/pkgsrc" ] || ( cd $BASEDIR && tar xpf $TARBALL )
[ -x /usr/pkg/bin/doas ] || ( cd $BASEDIR/pkgsrc/security/doas && make install )
[ -d /usr/pkg/etc ] || su root -c "mkdir -p /usr/pkg/etc"
[ -f /usr/pkg/etc/doas.conf ] || echo "permit nopass :wheel"  | su root -c "tee /usr/pkg/etc/doas.conf"
# test that it really works
doas id

set +x
[ -f /etc/mk.conf ] || {
cat <<EOF | su root -c "tee /etc/mk.conf"
# https://github.com/oasislinux/oasis/wiki/pkgsrc
ROOT_CMD := doas sh -c
# change to number of CPU cores:
# NOTE: We can't use "1C" because GNU Make does not undestand it (used for some packages)
MAKE_JOBS := `getconf NPROCESSORS_ONLN`
EOF
}
echo "pkgsrc is ready under $BASEDIR/pkgsrc"
exit 0
