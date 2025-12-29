#!/bin/sh
set -xeuo pipefail
sd=
[ `id -u` -eq 0 ] || sd=doas
$sd tcpdump -n -e -ttt -i npflog0
exit 0
