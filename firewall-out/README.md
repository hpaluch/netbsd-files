# NetBSD Firewall out

Here is my restrictive NetBSD NPF firewall that filters BOTH output and input connections.

WARNING! Only IPv4 supported so far!

Output connections can be temporarily enabled using scripts under `/usr/local/sbin`:
- [usr/local/sbin/npfctl-enable-http-out.sh](usr/local/sbin/npfctl-enable-http-out.sh) - enables
  both output http and https connections
- [usr/local/sbin/npfctl-enable-ssh-out.sh](usr/local/sbin/npfctl-enable-ssh-out.sh) - enables
  SSH output connections - also required for anoncvs access
- [usr/local/sbin/npfctl-disable-out.sh](usr/local/sbin/npfctl-disable-out.sh) - disables
  again all temporarily enabled output connections

Helper scripts:
- [usr/local/sbin/dump-fw-log-realtime.sh](usr/local/sbin/dump-fw-log-realtime.sh) - dumps firewall
  log in real-time as packets are processed
- [usr/local/sbin/dump-fw-log.sh](usr/local/sbin/dump-fw-log.sh) - dumps already
  logged packets

# Setup

As root run:
```shell
cat rc.conf.add >> /etc/rc.conf
find etc usr | cpio -pvdm /
```

Now you have to edit your new `/etc/npf.conf` and edit this part:

```
$wired_if = "vioif0"
$wired_addrs = ifaddrs($wired_if)

$ssh_client_ip = { 192.168.122.1, 192.168.0.56 }
$dns_ip = { 192.168.122.1, 78.157.167.7, 78.157.167.57 }
$dhcp_srv_ip = { 192.168.122.1, 192.168.0.1 }
```

Where:
- `vioif0` is my network interface (Virtio emulated network card) - replace
   with your network interface name
- `$ssh_client_ip` contains IP addresses of Clients that are allowed to login via
   SSH to this machine
- `$dns_ip` - DNS used by this machine. Warning! Non-recursive DNS not supported
   What is the difference:
   - recursive DNS will completely serve your query including additional
     requests to parent DNS servers to gather required information.
     So client needs to access only 1 fixed DNS server for any query
   - non-recursive DNS - will not server complete DNS query (unless
     already cached) but rather will tell client what DNS server
     to be contacted to get answer. In such case client must be able
     to connect any DNS server anywhere on Internet
- `$dhcp_srv_ip` - IP address of your DHCP server that assigns IP address to this machine.

And reboot machine. Carefully review logged packets using `dump-fw-log.sh`

