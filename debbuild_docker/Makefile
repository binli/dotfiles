.PHONY: all noble resolute chives debian run-noble run-resolute run-chives run-questing run-debian clean

NOBLE_VERSION = 24.04
RESOLUTE_VERSION = 26.04
DEBIAN_VERSION = experimental

# Define a variable for the Docker images to build
IMAGES = noble resolute

# Define a variable for the secrets file
SECRET_FILE = passwd.txt
CHIVES_ENV_FILE ?= /work/init/dotfiles_c/pes/chives.env

# Target to build all images
all: $(IMAGES)

# Rule to build individual service images
$(IMAGES):
	docker build --secret id=ubuntu,src=$(SECRET_FILE) \
		--build-arg UBUNTU_VERSION=$(if $(filter noble,$@),$(NOBLE_VERSION),$(RESOLUTE_VERSION)) \
		-t deb:$@ -f Dockerfile .

chives:
	docker build --build-arg UBUNTU_VERSION=$(RESOLUTE_VERSION) \
		-t deb:resolute-chives -f Dockerfile.chives .

debian:
	docker build --secret id=ubuntu,src=$(SECRET_FILE) \
		--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
		-t deb:debian -f Dockerfile.debian .

run-resolute: resolute
	docker run -it --rm -v /work/init/dotfiles_c/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /work/init/dotfiles_c/launchpad.credentials.binli:/home/ubuntu/launchpad.credentials \
		-v /work/init/oem-scripts:/home/ubuntu/.config/oem-scripts \
		-v /source:/source \
		deb:resolute bash

run-chives: chives
	docker run -it --rm -v /work/init/dotfiles_c/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /work/init/dotfiles_c/launchpad.credentials.binli:/home/ubuntu/launchpad.credentials \
		-v /work/init/oem-scripts:/home/ubuntu/.config/oem-scripts \
		-v /source:/source \
		-v /work/init/dotfiles_c/pes/config:/home/ubuntu/.pes/config \
		--mount "type=bind,src=$(CHIVES_ENV_FILE),dst=/home/ubuntu/.pes/chives.env,readonly" \
		deb:resolute-chives

run-noble: noble
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /work/init/launchpad.credentials.binli:/home/ubuntu/launchpad.credentials \
		-v /work/init/oem-scripts:/home/ubuntu/.config/oem-scripts \
		-v /source:/source \
		deb:noble bash

run-debian: debian
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /source:/source \
		-v ../homerc/dput.cf:/home/ubuntu/.dput.cf \
		deb:debian bash

clean:
	@echo "Removing Docker images: $(IMAGES)"
	-docker rmi deb:noble deb:resolute deb:debian deb:resolute-chives
