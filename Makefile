export
TOURNEY_NAME      ?= INSTA - STS \#1
TOURNEY_MAP_POOL  ?= complex douze duel7 kffa memento ot turbine
SERVER_ALLOCATION ?= EU=1.2.3.4=2.3.4.5 NA=3.4.5.6=4.5.6.7# <region>=<server IP>[=<proxy IP>] ...

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


proxies: check-config $(foreach srv,${SERVER_ALLOCATION},proxy-${srv})

proxy-%: parts=$(subst =, ,$*)
proxy-%: SERVER_REGION=$(word 1,${parts})
proxy-%: SERVER_IP=$(word 2,${parts})
proxy-%: PROXY_IP=$(word 3,${parts})
proxy-%:
	$(MAKE) -C proxy clean deploy


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


scripts: admins.cfg participants.cfg
.PHONY: scripts

# CLEANED_ALLOCATION drops the proxy IPs from SERVER_ALLOCATION
admins.cfg participants.cfg: CLEANED_ALLOCATION=$(shell echo ${SERVER_ALLOCATION} | sed -E 's/([0-9])=([0-9]+\.?){4}/\1/g')
admins.cfg participants.cfg:
	cp -f "$@.tpl" "$@"
	sed -i 's/<tourney_name>/${TOURNEY_NAME}/g' "$@"
	sed -i 's/<tourney_map_pool>/${TOURNEY_MAP_POOL}/g' "$@"
	sed -i 's/<server_allocation>/${CLEANED_ALLOCATION}/g' "$@"
.PHONY: admins.cfg participants.cfg


clean:
	$(MAKE) -C server clean
	rm -f *.cfg
.PHONY: clean
