#!/bin/ash

apk upgrade --update-cache
apk add --upgrade nftables libstdc++ envsubst

rc-update add nftables boot
rc-service nftables start

./update_p1xbraten_binary.sh
./update_maps.sh

add_service() {
    ln -s /etc/init.d/p1xbraten /etc/init.d/p1xbraten.$1
    rc-update add p1xbraten.$1 default
}

for i in $(seq 1 4); do
    add_service $i
    rc-service p1xbraten.$i start
done
