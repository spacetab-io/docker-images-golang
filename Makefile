# Available golang versions to build images
GOLANG_VERSIONS=1.12 1.13 1.14 1.15 1.16 1.17

# Linter images data
IMAGE_LINT = spacetabio/docker-linter-golang
VERSION_LINT = 1.0.10 # increment it if golangci-lint params will changed
GOLANGCI_VERSION=v1.46.2
GOLANGCI_CONFIG_VERSION=v1.0.1

# Test images data
IMAGE_TEST = spacetabio/docker-test-golang
VERSION_TEST = 1.0.3

# Build images data
IMAGE_BUILD = spacetabio/docker-build-golang
VERSION_BUILD = 1.1.4

# Base images data
IMAGE_BASE = spacetabio/docker-base-golang
VERSION_BASE = 1.0.6 # increment it if alpine version will changed
ALPINE_VERSION = 3.15


build-linter-image:
	cd ./linter && \
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	GOLANGCI_VERSION=${GOLANGCI_VERSION} \
	GOLANGCI_CONFIG_VERSION=${GOLANGCI_CONFIG_VERSION} \
	IMAGE=${IMAGE_LINT} \
	VERSION=${VERSION_LINT} \
	./build.sh

build-test-image:
	cd ./test && \
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE="${IMAGE_TEST}" \
	VERSION="${VERSION_TEST}" \
	./build.sh

build-build-image:
	cd ./build && \
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE="${IMAGE_BUILD}" \
	VERSION="${VERSION_BUILD}" \
	./build.sh

build-base-image:
	cd ./base && \
    	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
    	ALPINE_VERSION="${ALPINE_VERSION}" \
    	IMAGE="${IMAGE_BASE}" \
    	VERSION="${VERSION_BASE}" \
    	./build.sh

build-all: build-linter-image build-test-image build-build-image build-base-image

push-linter-image:
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE=${IMAGE_LINT} \
	VERSION=${VERSION_LINT} \
	./push.sh

push-test-image:
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE=${IMAGE_TEST} \
	VERSION=${VERSION_TEST} \
	./push.sh

push-build-image:
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE=${IMAGE_BUILD} \
	VERSION=${VERSION_BUILD} \
	./push.sh

push-base-image:
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	IMAGE=${IMAGE_BASE} \
	VERSION=${VERSION_BASE} \
	./push.sh

push-all: push-linter-image push-test-image push-build-image push-base-image

all: build-all push-all

all-for-base: build-base-image push-base-image
all-for-build: build-build-image push-build-image
all-for-linter: build-linter-image push-linter-image
all-for-test: build-test-image push-test-image