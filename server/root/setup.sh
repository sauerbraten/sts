#!/bin/ash

apk upgrade --update-cache
apk add --upgrade nftables libstdc++ envsubst

# basic firewall, see /etc/nftables.d/sauer.nft
rc-update add nftables boot
rc-service nftables start

# download and compile the latest p1xbraten server
./update_p1xbraten_binary.sh

# download the 2020 maps, but slimmed down
wget -q -O - https://static.p1x.pw/slim_ogzs.tar.gz | tar -xzof -

# register and start services
for i in $(seq 1 4); do
    ln -s /etc/init.d/p1xbraten /etc/init.d/p1xbraten.$i
    rc-update add p1xbraten.$i default
    rc-service p1xbraten.$i start
done
