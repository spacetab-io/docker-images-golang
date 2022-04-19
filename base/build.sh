#!/usr/bin/env bash

render() {
sedStr="
  s!%%GOLANG_VERSION%%!${golang_version}!g;
  s!%%ALPINE_VERSION%%!${ALPINE_VERSION}!g;
"

sed -r "$sedStr" $1
}

IFS=' ' read -r -a go_versions <<< ${GOLANG_VERSIONS}
for golang_version in ${go_versions[@]}; do
  mkdir ${golang_version}
  echo "Make base dockerfile for ${golang_version}"
  render Dockerfile.tmpl > ${golang_version}/Dockerfile
  docker build -f ${golang_version}/Dockerfile -t ${IMAGE}:${golang_version}-${VERSION} ${golang_version}
  rm -rf ${golang_version}
done

