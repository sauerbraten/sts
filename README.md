# Sauerworld Tournament Servers

## Prerequisites

You need a fly.io account for this.

The script will create one app per server region. For example, to have EU and NA servers, we need two apps. Each app can run multiple instances of the p1xbraten server, so with just one app for the EU region, you can have four or even more game servers.

Each app also gets a dedicated IPv4, which currently costs 2$/month (billed monthly).

> In case you have trouble with DDoS attacks, you should just deploy new servers with new IPs, but this might cost an additional 2$ per app in that month (I didn't try it) and you have to distribute new configs. On the other hand, I'm pretty sure fly.io has good DDoS defenses, so this might never be an issue.

## Deployment

Pre-deployment checklist:

1. Update the config at the top of the Makefile
2. Review server/template/server-init.cfg.tpl, especially `updatemaster` (make sure it's 0 when using a proxy!)
3. Make sure server/users.cfg contains the desired auth domain and a key for each tournament admin, with 'a' (admin) permissions

To deploy:

1. `make servers`
2. copy the last line of the output, e.g. `EU 169.155.63.159 4`
3. `TOURNEY_SERVER_ALLOCATION='<output from above>' make scripts`

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

After the tournament is over, simply delete all tourney-* apps in the fly.io dashboard.
