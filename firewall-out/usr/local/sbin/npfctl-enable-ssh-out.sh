#!/bin/sh
set -xeuo pipefail
sd=
[ `id -u` -eq 0 ] || sd=doas
$sd npfctl rule "dyn-wired" add pass stateful out final proto tcp flags S/FSRA to any port ssh
$sd npfctl rule dyn-wired list
exit 0
