#!/bin/sh
set -xeuo pipefail
sd=
[ `id -u` -eq 0 ] || sd=doas
$sd npfctl rule dyn-wired flush
$sd npfctl rule dyn-wired list
exit 0
