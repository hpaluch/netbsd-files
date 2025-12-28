#!/bin/sh
set -xeuo pipefail

which pkgin || \
 PKG_PATH="https://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/$(uname -p)/$(uname -r|cut -f '1 2' -d.|cut -f 1 -d_)/All" pkg_add pkgin
exit 0
