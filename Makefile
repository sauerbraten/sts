export
TOURNEY_NAME       ?= Weekly FFA
TOURNEY_MAP_POOL   ?= ot turbine hashi
# for EU & NA servers, use 'EU:1.2.3.4 NA:2.3.4.5'
SERVER_ALLOCATION  ?= EU:128.140.40.219
SERVER_DESCRIPTION ?= SW Tourney Server


check-config:
ifndef TOURNEY_NAME
	$(error TOURNEY_NAME is undefined)
endif
ifndef TOURNEY_MAP_POOL
	$(error TOURNEY_MAP_POOL is undefined)
endif
ifndef SERVER_ALLOCATION
	$(error SERVER_ALLOCATION is undefined)
endif
ifndef SERVER_DESCRIPTION
	$(error SERVER_DESCRIPTION is undefined)
endif
	@echo "config is valid"
.PHONY: check-config


EU_IP=$(subst EU:,,$(filter EU:%,${SERVER_ALLOCATION}))
NA_IP=$(subst NA:,,$(filter NA:%,${SERVER_ALLOCATION}))
servers: check-config
ifneq (${EU_IP},)
	SERVER_REGION=EU SERVER_IP=${EU_IP} $(MAKE) -C server deploy
endif
ifneq (${NA_IP},)
	SERVER_REGION=NA SERVER_IP=${NA_IP} $(MAKE) -C server deploy
endif
.PHONY: servers


artifacts:
ifndef SERVER_ALLOCATION
	$(error SERVER_ALLOCATION is undefined)
endif
ifneq (${EU_IP},)
	mkdir -p "${EU_IP}"
	scp -r root@${EU_IP}:/root/servers/* "${EU_IP}/" || \
		scp -r root@${EU_IP}:/root/archived/* "${EU_IP}/"
endif
ifneq (${NA_IP},)
	mkdir -p "${NA_IP}"
	scp -r root@${NA_IP}:/root/servers/* "${NA_IP}/" || \
		scp -r root@${NA_IP}:/root/archived/* "${NA_IP}/"
endif
.PHONY: artifacts


scripts: player.cfg admin.cfg
.PHONY: scripts

player.cfg: check-config
	envsubst < base.cfg.tpl > player.cfg
	cat player.cfg.tpl >> player.cfg
.PHONY: player.cfg

admin.cfg: player.cfg
	cp -f player.cfg admin.cfg
	cat admin.cfg.tpl >> admin.cfg
.PHONY: admin.cfg


clean:
	$(MAKE) -C server clean
	rm -f *.cfg
.PHONY: clean
