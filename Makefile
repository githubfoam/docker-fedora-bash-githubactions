IMAGE := alpine/fio
APP:="scripts/usernetes-containerd.sh"

deploy-manual-build:
	bash scripts/deploy-manual-build.sh
	
push-image:
	docker push $(IMAGE)

.PHONY: deploy-libvirt deploy-vagrant deploy-packer deploy-terraform push-image
