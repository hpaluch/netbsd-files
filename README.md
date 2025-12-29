# NetBSD configuration files

My NetBSD scripts and configuration files.

Please see also [My NetBSD wiki page](https://github.com/hpaluch/hpaluch.github.io/wiki/NetBSD)
and list of [My all wiki pages](https://github.com/hpaluch/hpaluch.github.io/wiki).

Usually I start with:

- [scripts/01-install-pkgin.sh](scripts/01-install-pkgin.sh) to install `pkgin`
- [scripts/10-install-cli-packages.sh](scripts/10-install-cli-packages.sh) - to install
  my favorite CLI packages using `pkgin`

I'm testing restrictive firewall that filters BOTH output and input
connections. See [firewall-out/](firewall-out/) for instructions.

