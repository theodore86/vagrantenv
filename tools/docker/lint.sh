#!/usr/bin/env bash
set -o pipefail

# shellcheck source=tools/helpers/system.sh
source ../helpers/system.sh
# shellcheck source=tools/helpers/log.sh
source ../helpers/log.sh

IMAGE="${1:-theodore86/vagrantenv-ci}"
TAG="${2:-0.0.4}"

_docker_lint() {
    docker run --platform linux/amd64 \
    --rm \
    -w /app \
    -v "${PWD}:/app" \
    -e BUNDLE_PATH=/app/
    -e PRE_COMMIT_HOME=/app/.cache \
    -e VAGRANT_HOME=/app/.vagrant.d \
    "${IMAGE}:${TAG}" tox
}

docker_linter() {
    local cuid cgid repo
    is_program_installed docker || error 'Docker is required to be installed'
    cuid=$(docker run --platform linux/amd64 --rm ${IMAGE}:${TAG} id -u) || error 'Docker run command failed'
    cgid=$(docker run --platform linux/amd64 --rm ${IMAGE}:${TAG} id -g) || error 'Docker run command failed'
    { cd ../../ && repo="$(basename $PWD)" && \
      cd ../ && sudo chown -R "$cuid:$cgid" "${repo}" 2>/dev/null;
    } || error "Cannot change $repo permissions"
    cd $repo && _docker_lint
    { cd ../ && sudo chown -R "$(id -un):$(id -gn)" "${repo}" 2> /dev/null; } || \
        error "Cannot restore $repo permissions"
}

docker_linter
