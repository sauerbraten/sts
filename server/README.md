This directory contains scaffolding and scripts to install four instances of p1xbraten as supervised OpenRC services. Read the Makefile for more details on deployment and setup.

Each instance has its own "home" directory under root/server/{1..4}, where a server-init.cfg only defines an `sts_num` variable as 1/2/3/4. The actual configuration happens in root/, which every instance has configured as additional "package" directory:

- vars.cfg contains sts_* variables derived from env vars,
- server.cfg contains the main configuration,
- users.cfg contains the auth setup and user keys,
- default_map_rotation.cfg contains the vanilla 2020 edition map rotation setup.

Also, root/packages/ contains the 2020 edition maps as slim .ogz files for `/checkmaps` support.

During the `make` process, some environment variables are written to vars.cfg. Every instance executes its own server-init.cfg, which executes the shared server.cfg, which executes vars.cfg before doing anything else. This way, things like the server port, description, and MOTD can be configured in server.cfg across all regions and instances.

On top of the four p1xbraten services, an nftables service is installed with a basic firewall configuration (see [etc/nftables.d/p1xbraten.nft](etc/nftables.d/p1xbraten.nft)). This is a best-effort attempt to mitigate DDoS attacks, even though most VPS hosters advertise built-in DDoS mitigation already.
