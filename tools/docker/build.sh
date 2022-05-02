#!/usr/bin/env bash

[[ -n $DEBUG ]] && set -x

set -o pipefail

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=tools/helpers/system.sh
source ${CWD}/../helpers/system.sh
# shellcheck source=tools/helpers/log.sh
source ${CWD}/../helpers/log.sh

REGISTRY_USER="${REGISTRY_USER:-}"
REGISTRY_PASS="${REGISTRY_PASS:-}"
IMAGE="${IMAGE:-theodore86/vagrantenv-ci}"
TAG="${TAG:-}"


_login() {
  local user pass
  user="$1"
  pass="$2"
  info "Login to docker registry"
  docker login --username "${user}" --password-stdin <<< "${pass}" &>/dev/null || \
      error 'Fail to login to docker registry, verify your credentials'
}

_build() {
  local image tag
  image="$1"
  tag="$2"
  info "Building docker image: $image:$tag"
  { cd $CWD && cd ../../ && \
    docker image build --pull -t ${image}:${tag} . && \
    docker image tag ${image}:${tag} ${image}:latest
  } || error "Fail to build docker image: $image:$tag"
}

_push() {
   local image tag
   image="$1"
   tag="$2"
   info "Pushing docker image: $image:$tag"
   {
     docker push "$image:$tag" && \
     docker push "$image:latest"
   } || error "Fail to push docker image: $image:$tag"
}

main() {
  [[ $TAG =~ ^([0-9]+\.){2}[0-9]+ ]] || error 'Docker image tag of semantic version is required'
  is_program_installed docker || error 'Docker is required to be installed'
  _login ${REGISTRY_USER} ${REGISTRY_PASS}
  _build ${IMAGE} ${TAG}
  _push ${IMAGE} ${TAG}
}

main
