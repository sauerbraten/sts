#!/bin/ash

apk upgrade --update-cache
apk add --upgrade nftables

# basic firewall, see /etc/nftables.d/p1xbraten.nft
rc-update add nftables boot
rc-service nftables start

# download and compile the latest sauer-proxy
./update_sauer-proxy_binary.sh

# register and start services
for i in $(seq 1 8); do
    ln -s /etc/init.d/sauer-proxy /etc/init.d/sauer-proxy.$i
    rc-update add sauer-proxy.$i default
    rc-service sauer-proxy.$i start
done
