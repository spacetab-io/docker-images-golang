IMAGE_LINT = spacetabio/docker-linter-golang
IMAGE_TEST = spacetabio/docker-test-golang
IMAGE_BUILD = spacetabio/docker-build-golang
IMAGE_BASE = spacetabio/docker-base-golang
VERSION_LINT = 1.0.4
VERSION_TEST = 1.0.2
VERSION_BUILD = 1.1.2
VERSION_BASE = 1.0.2
GOLANG_VERSIONS=1.12 1.13 1.14
GOLANGCI_VERSION=v1.24.0


build-linter-image:
	cd ./linter && \
	GOLANG_VERSIONS="${GOLANG_VERSIONS}" \
	GOLANGCI_VERSION=${GOLANGCI_VERSION} \
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