root/.env:
	echo 'export SERVER_IP="${SERVER_IP}"' > root/.env
.PHONY: root/.env

overlay.tar.gz: root/.env
	tar --create --gzip --verbose --owner=root --group=root --file "$@" etc root

deploy: overlay.tar.gz
ifndef PROXY_IP
	$(info "PROXY_IP is undefined, skipping deployment")
else
	scp $< root@${PROXY_IP}:/root/
	ssh root@${PROXY_IP} "tar -xzf $< -C / && rm $< && ./setup.sh"
	ssh root@${PROXY_IP} "netstat -anup | grep proxy"
endif

clean:
	rm -f root/.env overlay.tar.gz
.PHONY: clean
