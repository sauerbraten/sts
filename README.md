# Sauerworld Tourney Servers

This repository has everything you need to deploy four p1xbraten servers each on one or more Alpine Linux VPS, plus `make` commands to generate the corresponding `/tourney` cubescript.

- [Prerequisites](#prerequisites)
- [Deployment](#deployment)
- [Player commands](#player-commands)
  - [`/pool`](#pool)
  - [`/tourney`](#tourney)
- [Admin commands](#admin-commands)
  - [`/tourney_announce_pool`](#tourney_announce_pool)
  - [`/tourney_announce_match <p1> <p2> <server>`](#tourney_announce_match-p1-p2-server)
  - [`/tourney_spec_all [<team>]`](#tourney_spec_all-team)
- [Afterwards](#afterwards)

## Prerequisites

You need a Alpine Linux box with a public IPv4 for this. Hetzner's CX22 or CAX11 "Cloud Servers" work nicely, with the latter scoring higher in benchmarks for the same price. Pick the Nuremberg data center (most players are located in the EU).

> In order to register with the master server, outgoing traffic needs to originate from the ingress IP. Also, you need to be able to listen on two UDP ports per instance. Most "serverless" container hosting services will not work for those reasons. Fly.io at least supports UDP on arbitrary ports, but you won't be able to register with the master server since outgoing TCP traffic uses IPs you can't listen on. Plain old virtual Linux boxes usually don't have all these problems, and are billed by the hour these days, so just use those.

To get Alpine installed on the Hetzner VPS, follow [this guide](https://web.archive.org/web/20240720225201/https://lemonsh.moe/blog/alpine-hetzner/). After that, follow the [Alpine docs](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html). Make sure you can SSH into the server as root.

At this point, you might want to take a snapshot of your server in the Hetzner dashboard, to skip the Alpine setup in the future.

If you need another server in a different region, repeat these steps (or just create more servers from a snapshot). Note down the IPs of these servers, as you will need them to generate the player scripts.

> To hide the tourney servers' IPs, you will need another VPS to run the sauer-duels proxy. That's out of scope for this guide.

## Deployment

Pre-flight checklist:

1. Update the config at the top of the [Makefile](./Makefile). You need the server IP(s) in the SERVER_ALLOCATION variable!
2. Review [server/root/server-init.cfg.tpl](./server/root/server-init.cfg.tpl), especially `updatemaster` (make sure it's 0 when using a proxy)
3. Make sure [server/root/users.cfg](./server/root/users.cfg) contains the desired auth domain and a key for each tournament admin, with 'a' (admin) permissions

To deploy the servers, run `make servers`. This will generate tarballs of scripts and configuration, copy them to the server, then set up four p1xbraten services. Wait for everything to finish, then verify that p1xbraten is listening on ports 1000, 2000, 3000, 4000 (and more).

To generate the cubescript snippets, run `make scripts`. A player.cfg and admin.cfg are generated and will show up next to this README.

Share admin.cfg with all tournament admins. Share player.cfg with all other participants.

> There is no secret knowledge in admin.cfg, but without an admin key, you cannot use the additional commands.

## Player commands

### `/pool`

Prints the tournament's map pool to the console.

### `/tourney`

Opens a GUI with the map pool and buttons to connect to the tourney servers.

## Admin commands

### `/tourney_announce_pool`

Prints the map pool to the console of everyone on the server.

### `/tourney_announce_match <p1> <p2> <server>`

Announces an upcoming match to everyone on the server. For example: `/tourney_announce_match w00p RB EU2`.

### `/tourney_spec_all [<team>]`

Moves all players to spectator. If you pass a team name, only players in that team are moved to spec.

## Afterwards

After the tournament is over, fetch all the demos and logs: `make artifacts`. Then, simply delete the server(s) in Hetzner's dashboard. If you don't do this, you will be reminded when they bill you...
