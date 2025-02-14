export
TOURNEY_NAME      ?= Weekly FFA
TOURNEY_MAP_POOL  ?= ot turbine hashi
SERVER_ALLOCATION ?= EU=135.181.111.59# NA=2.3.4.5

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
	@echo "config is valid"
.PHONY: check-config

servers: check-config $(foreach srv,${SERVER_ALLOCATION},server-${srv})

server-%: parts=$(subst =, ,$*)
server-%: SERVER_REGION=$(word 1,${parts})
server-%: SERVER_IP=$(word 2,${parts})
server-%:
	$(MAKE) -C server clean deploy

artifacts: $(foreach srv,${SERVER_ALLOCATION},artifacts-${srv})
artifacts:
ifndef SERVER_ALLOCATION
	$(error SERVER_ALLOCATION is undefined)
endif

artifacts-%: parts=$(subst =, ,$*)
artifacts-%: ip=$(word 2,${parts})
artifacts-%:
	mkdir "${ip}"
	scp -r root@${ip}:/root/servers/* "${ip}/" || \
		scp -r root@${ip}:/root/archived/* "${ip}/"

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
