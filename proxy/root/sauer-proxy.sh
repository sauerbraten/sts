#!/bin/ash

cd "$(dirname "$0")"

server_num=$1
source .env # sets SERVER_IP

exec ./sauer-proxy --listen-port ${server_num}000 --remote-port ${server_num}000 --register-master --forward-ips --delay 1000 ${SERVER_IP}
