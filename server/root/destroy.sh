#!/bin/ash

remove_service() {
    rc-update del p1xbraten.$1 default
    rm -f /etc/init.d/p1xbraten.$1
}

for i in $(seq 1 4); do
    rc-service p1xbraten.$i stop || exit
    remove_service $i
done

rm -f -r servers

rm -f -r packages
rm -f p1xbraten_server

rc-service nftables stop
rc-update del nftables boot
