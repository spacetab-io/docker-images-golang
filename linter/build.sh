#!/usr/bin/env bash

render() {
sedStr="
  s!%%GOLANG_VERSION%%!${golang_version}!g;
  s!%%GOLANGCI_VERSION%%!$GOLANGCI_VERSION!g;
"

sed -r "$sedStr" $1
}

IFS=' ' read -r -a go_versions <<< ${GOLANG_VERSIONS}
for golang_version in ${go_versions[@]}; do
  mkdir ${golang_version}
  echo "Make dockerfile for ${golang_version} and linter version ${GOLANGCI_VERSION}"
  render Dockerfile.tmpl > ${golang_version}/Dockerfile
  cp ./.golangci.yml ${golang_version}
  docker build -f ${golang_version}/Dockerfile --build-arg -t ${IMAGE}:${golang_version}-${VERSION} ${golang_version}
  rm -rf ${golang_version}
done

