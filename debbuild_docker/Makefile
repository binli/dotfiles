.PHONY: all noble questing focal debian run-noble run-questing run-focal run-debian clean

NOBLE_VERSION = 24.04
QUESTING_VERSION = 25.10
FOCAL_VERSION = 20.04
DEBIAN_VERSION = experimental

# Define a variable for the Docker images to build
IMAGES = noble questing

# Define a variable for the secrets file
SECRET_FILE = passwd.txt

# Target to build all images
all: $(IMAGES)

# Rule to build individual service images
$(IMAGES):
	docker build --secret id=ubuntu,src=$(SECRET_FILE) \
		--build-arg UBUNTU_VERSION=$(if $(filter noble,$@),$(NOBLE_VERSION),$(QUESTING_VERSION)) \
		-t deb:$@ -f Dockerfile .

focal:
	docker build --secret id=ubuntu,src=$(SECRET_FILE) \
		--build-arg UBUNTU_VERSION=$(FOCAL_VERSION) \
		-t deb:focal -f Dockerfile.chives .

debian:
	docker build --secret id=ubuntu,src=$(SECRET_FILE) \
		--build-arg DEBIAN_VERSION=$(DEBIAN_VERSION) \
		-t deb:debian -f Dockerfile.debian .

run-questing: questing
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /source:/source \
		deb:questing bash

run-noble: noble
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /work/init/launchpad.credentials.binli:/home/ubuntu/launchpad.credentials \
		-v /work/init/oem-scripts:/home/ubuntu/.config/oem-scripts \
		-v /source:/source \
		deb:noble bash

run-focal: focal
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /source:/source \
		deb:focal bash

run-debian: debian
	docker run -it --rm -v /work/init/ssh:/home/ubuntu/.ssh \
		-v /work/init/gnupg:/home/ubuntu/.gnupg \
		-v /source:/source \
		-v ../homerc/dput.cf:/home/ubuntu/.dput.cf \
		deb:debian bash

clean:
	@echo "Removing Docker images: $(IMAGES)"
	-docker rmi deb:noble deb:questing
