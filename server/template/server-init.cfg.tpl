serverip "${LISTEN_ADDRESS}"
serverport ${SERVER_NUM}000

serverdesc "${SERVER_DESCRIPTION} ${SERVER_REGION}${SERVER_NUM}"

servermotd "Welcome to the ^fs^f8${SERVER_REGION}${SERVER_NUM} server^fr for ${TOURNEY_NAME}!"

maxclients 128
serverbotlimit 0

exec users.cfg

// set to 0 when using a proxy
updatemaster 1

// instead, this proxy will register with the master (and we trust it to forward us the real IPs)
addtrustedproxyip "${PROXY_IP}"

// disable 'private' mode
publicserver 2

// keep all the demos
autorecorddemo 1
maxdemos 25
maxdemosize 31

// let any player pause
restrictpausegame 0

// don't shuffle teams
persistteams 1

// don't punish any teamkills
teamkillkickreset
teamkillkick "*" 10000 -1
ctftkpenalty 0

// enable overtime
overtime 1

// start with default map rotation
exec default_map_rotation.cfg

// and last but not least, ban fragginfucker for good measure
75.109.224.0/19
75.109.0.0/17
