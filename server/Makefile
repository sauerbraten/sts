export OUTFILE=overlay-${SERVER_REGION}.tar.gz

check-vars:
ifndef SERVER_REGION
	$(error SERVER_REGION is undefined)
endif
ifndef SERVER_DESCRIPTION
	$(error SERVER_DESCRIPTION is undefined)
endif
ifndef TOURNEY_NAME
	$(error TOURNEY_NAME is undefined)
endif
.PHONY: check-vars


config.env: check-vars
	echo 'SERVER_REGION="${SERVER_REGION}"'            > root/config.env
	echo 'SERVER_DESCRIPTION="${SERVER_DESCRIPTION}"' >> root/config.env
	echo 'TOURNEY_NAME="${TOURNEY_NAME}"'             >> root/config.env
.PHONY: config.env


tarball: config.env
	# to ensure all the files are owned by root, we use a Dockerfile
	podman build \
		--security-opt label=disable \
		--build-arg OUTFILE="${OUTFILE}" \
		--volume=$(shell pwd):/out \
		--tag alpine-p1x-overlay \
		.
	# we abuse the build step as VM, we don't actually need the image
	podman rmi alpine-p1x-overlay
.PHONY: tarball


deploy: tarball
ifndef SERVER_IP
	$(info "SERVER_IP is undefined, skipping deployment")
else
	scp ${OUTFILE} root@${SERVER_IP}:/root/overlay.tar.gz
	ssh root@${SERVER_IP} "tar -xzvf overlay.tar.gz -C /"
	ssh root@${SERVER_IP} "./setup.sh"
	ssh root@${SERVER_IP} "netstat -anup"
endif
.PHONY: deploy


clean:
	rm -f root/config.env overlay*.tar.gz
.PHONY: clean
