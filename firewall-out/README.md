# NetBSD Firewall out

Here is my restrictive firewall that filters BOTH output and input connections.

WARNING! Only IPv4 supported so far(!)

Output connections can be temporarily enabled using scripts under `/usr/local/sbin`:
- [usr/local/sbin/npfctl-enable-http-out.sh](usr/local/sbin/npfctl-enable-http-out.sh) - enables
  both http and https
- [usr/local/sbin/npfctl-enable-ssh-out.sh](usr/local/sbin/npfctl-enable-ssh-out.sh) - enables
  SSH out - also required for anoncvs access

Helper scripts:
- [usr/local/sbin/dump-fw-log-realtime.sh](usr/local/sbin/dump-fw-log-realtime.sh) - dumps firewall
  log in real-time as packets are processed
- [usr/local/sbin/dump-fw-log.sh](usr/local/sbin/dump-fw-log.sh) - dumps already
  logged packets

# Setup

As root run:
```shell
cat rc.conf.add | tee -a /etc/rc.conf
find etc usr | cpio -pvdm /
```

Now you have to edit your new `/etc/npf.conf` and edit this part:

```
$ssh_client_ip = { 192.168.122.1, 192.168.0.56 }
$dns_ip = { 192.168.122.1, 78.157.167.7, 78.157.167.57 }
$dhcp_srv_ip = { 192.168.122.1, 192.168.0.1 }
```

Where:
- `$ssh_client_ip` contains IP addresses of Clients that can login via SSH to this machine
- `$dns_ip` - DNS used by this machine. Warning! Non-recursive DNS not supported (that would
   required free access to any IP address
- `$dhcp_srv_ip` - IP address of your DHCP server that assigns IP address to this machine.

And reboot machine. Carefully review logged packets using `dump-fw-log.sh`

