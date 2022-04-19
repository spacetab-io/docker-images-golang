#!/usr/bin/env bash

render() {
sedStr="
  s!%%GOLANG_VERSION%%!${golang_version}!g;
  s!%%GOLANGCI_VERSION%%!${GOLANGCI_VERSION}!g;
  s!%%GOLANGCI_CONFIG_VERSION%%!${GOLANGCI_CONFIG_VERSION}!g;
"

sed -r "$sedStr" $1
}

IFS=' ' read -r -a go_versions <<< ${GOLANG_VERSIONS}
for golang_version in ${go_versions[@]}; do
  mkdir ${golang_version}
  echo "Make linter dockerfile for ${golang_version}, linter version ${GOLANGCI_VERSION} and config for it with version ${GOLANGCI_CONFIG_VERSION}"
  render Dockerfile.tmpl > ${golang_version}/Dockerfile
  docker build -f ${golang_version}/Dockerfile -t ${IMAGE}:${golang_version}-${VERSION} ${golang_version}
  rm -rf ${golang_version}
done

