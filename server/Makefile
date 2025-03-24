root/vars.cfg:
ifndef TOURNEY_NAME
	$(error TOURNEY_NAME is undefined)
endif
ifndef SERVER_REGION
	$(error SERVER_REGION is undefined)
endif
	echo 'sts_tourney_name = "${TOURNEY_NAME}"' > root/vars.cfg
	echo 'sts_region = "${SERVER_REGION}"'     >> root/vars.cfg
	echo 'sts_proxy_ip = "${PROXY_IP}"'        >> root/vars.cfg
.PHONY: root/vars.cfg

overlay.tar.gz: root/vars.cfg
	tar --create --gzip --verbose --owner=root --group=root --file "$@" etc root

deploy: overlay.tar.gz
ifndef SERVER_IP
	$(info "SERVER_IP is undefined, skipping deployment")
else
	scp $< root@${SERVER_IP}:/root/
	ssh root@${SERVER_IP} "tar -xzf $< -C / && rm $< && ./setup.sh"
	ssh root@${SERVER_IP} "netstat -anup | grep p1x"
endif

clean:
	rm -f root/vars.cfg overlay.tar.gz
.PHONY: clean
