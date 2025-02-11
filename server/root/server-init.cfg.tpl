serverip "0.0.0.0"
serverport ${SERVER_NUM}000

serverdesc "${SERVER_DESCRIPTION} ${SERVER_REGION}${SERVER_NUM}"

servermotd "Welcome to the ^fs^f8${SERVER_REGION}${SERVER_NUM}^fr server for ^fs^f8${TOURNEY_NAME}^fr!"

maxclients 128
serverbotlimit 0

// set to 0 when using a proxy, to not leak the server IP on the master list
updatemaster 1

// if updatemaster is 0, the proxy set here register with the master instead (and we trust it to forward us the real IPs)
//addtrustedproxyip "${PROXY_IP}"

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

// configure local auth
exec users.cfg
