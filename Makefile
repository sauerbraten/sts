export
TOURNEY_NAME             ?= Weekly FFA
TOURNEY_MAP_POOL         ?= ot turbine hashi
SERVER_DESCRIPTION       ?= SW Tourney Server
SERVER_REGION_ALLOCATION ?= EU fra 4 # could also be "EU ams 2 NA ewr 3" for example
#PROXY_IP                 ?= # optional, let's see if fly.io has DDoS prevention


servers:
	# cd server && ./deploy_fly_apps.sh ${SERVER_REGION_ALLOCATION}
.PHONY: servers


scripts: player.cfg admin.cfg

player.cfg:
ifndef TOURNEY_SERVER_ALLOCATION
	$(error TOURNEY_SERVER_ALLOCATION is undefined)
endif
	envsubst < player.cfg.tpl > player.cfg

admin.cfg: player.cfg
	cp -f player.cfg admin.cfg
	cat admin.cfg.tpl >> admin.cfg


clean:
	rm -f server/*.toml
	rm -f *.cfg
