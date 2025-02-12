#!/bin/ash

# undos everything in setup.sh

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
