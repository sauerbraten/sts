#!/bin/ash

# undos everything in setup.sh, and deletes everything copied onto the server by `make servers`

for i in $(seq 1 8); do
    rc-service sauer-proxy.$i stop || true
    rc-update del sauer-proxy.$i default || true
    rm -f /etc/init.d/sauer-proxy.$i
done

rm -f -r proxies

rm -f sauer-proxy

rc-service nftables stop || true
rc-update del nftables boot || true

rm -f destroy.sh env sauer-proxy.sh setup.sh update_sauer-proxy_binary.sh
rm -f /etc/nftables.d/*.nft
