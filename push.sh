#!/usr/bin/env bash

IFS=' ' read -r -a go_versions <<< ${GOLANG_VERSIONS}
for golang_version in ${go_versions[@]}; do
  docker push ${IMAGE}:${golang_version}-${VERSION}
	docker tag ${IMAGE}:${golang_version}-${VERSION} ${IMAGE}:${golang_version}-latest
	docker push ${IMAGE}:${golang_version}-latest
done