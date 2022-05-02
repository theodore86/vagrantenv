#!/usr/bin/env bash

[[ -n $DEBUG ]] && set -x

set -o pipefail

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=tools/helpers/system.sh
source ${CWD}/../helpers/system.sh
# shellcheck source=tools/helpers/log.sh
source ${CWD}/../helpers/log.sh

IMAGE="${1:-theodore86/vagrantenv-ci}"
TAG="${2:-0.0.4}"

_linter() {
    docker run --platform linux/amd64 \
    --rm \
    -w /app \
    -v "${PWD}:/app" \
    -e BUNDLE_PATH=/app/ \
    -e PRE_COMMIT_HOME=/app/.cache \
    -e VAGRANT_HOME=/app/.vagrant.d \
    -e DEBUG="${DEBUG}" \
    "${IMAGE}:${TAG}" tox
}

_linux_linter() {
    local cuid cgid repo
    is_program_installed docker || error 'Docker is required to be installed'
    cuid=$(docker run --platform linux/amd64 --rm ${IMAGE}:${TAG} id -u) || error 'Docker run command failed'
    cgid=$(docker run --platform linux/amd64 --rm ${IMAGE}:${TAG} id -g) || error 'Docker run command failed'
    { cd $CWD && cd ../../ && repo="$(basename $PWD)" && \
      cd ../ && sudo chown -R "$cuid:$cgid" "${repo}" 2>/dev/null;
    } || error "Cannot change $repo permissions"
    cd $repo && _linter
    { cd ../ && sudo chown -R "$(id -un):$(id -gn)" "${repo}" 2> /dev/null; } || \
        error "Cannot restore $repo permissions"
}

_darwin_linter() {
    cd $CWD && cd ../../ && _linter
}

docker_linter() {
    if [[ $(get_ostype) == 'linux' ]]; then
        _linux_linter
    elif [[ $(get_ostype) == 'darwin' ]]; then
        _darwin_linter
    else
        error 'Not supported OS type for linting'
    fi
}

docker_linter
