#!/bin/ash

# undos everything in setup.sh, and deletes everything copied onto the server by `make servers`

for i in $(seq 1 4); do
    rc-service p1xbraten.$i stop || true
    rc-update del p1xbraten.$i default || true
    rm -f /etc/init.d/p1xbraten.$i
done

rm -f -r servers

rm -f -r packages
rm -f p1xbraten_server

rc-service nftables stop || true
rc-update del nftables boot || true

rm -f default_map_rotation.cfg destroy.sh server.cfg setup.sh update_p1xbraten_binary.sh users.cfg vars.cfg
rm -f /etc/nftables.d/*.nft
