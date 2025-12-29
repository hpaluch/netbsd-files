#!/bin/sh
set -xeuo pipefail
sd=
[ `id -u` -eq 0 ] || sd=doas
$sd tcpdump -n -e -tttt -r /var/log/npflog0.pcap
exit 0
