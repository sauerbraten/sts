root/vars.cfg:
ifndef TOURNEY_NAME
	$(error TOURNEY_NAME is undefined)
endif
ifndef SERVER_REGION
	$(error SERVER_REGION is undefined)
endif
	echo 'defsvar sts_tourney_name "${TOURNEY_NAME}"' > root/vars.cfg
	echo 'defsvar sts_region "${SERVER_REGION}"'     >> root/vars.cfg
	echo 'defsvar sts_proxy_ip "${PROXY_IP}"'        >> root/vars.cfg
.PHONY: root/vars.cfg

overlay.tar.gz: root/vars.cfg
	@# to ensure all the files are owned by root, we use a Dockerfile
	podman build \
		--quiet \
		--security-opt label=disable \
		--build-arg OUTFILE="$@" \
		--volume=$(shell pwd):/out \
		--tag alpine-p1x-overlay \
		.
	@# we abuse the build step as VM, we don't actually need the image
	podman rmi alpine-p1x-overlay >/dev/null

deploy: overlay.tar.gz
ifndef SERVER_IP
	$(info "SERVER_IP is undefined, skipping deployment")
else
	scp $< root@${SERVER_IP}:/root/
	ssh root@${SERVER_IP} "tar -xzvf $< -C /"
	ssh root@${SERVER_IP} "./setup.sh"
	ssh root@${SERVER_IP} "netstat -anup | grep p1x"
endif

clean:
	rm -f root/vars.cfg overlay.tar.gz
.PHONY: clean
