#!/usr/bin/env bash

[[ -n $DEBUG ]] && set -x

set -o pipefail

CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=tools/helpers/log.sh
source ${CWD}/../helpers/log.sh
# shellcheck source=tools/helpers/system.sh
source ${CWD}/../helpers/system.sh
# shellcheck source=tools/helpers/pacapt.sh
source ${CWD}/../helpers/pacapt.sh
# shellcheck source=tools/helpers/string.sh
source ${CWD}/../helpers/string.sh


VAGRANT_VERSION='2.3.4'
VAGRANT_VIRTUALBOX_VERSION='virtualbox'
VAGRANT_TMP_DIR='/tmp/downloads'
VAGRANT_TMP_DEB="${VAGRANT_TMP_DIR}/vagrant_${VAGRANT_VERSION}.deb"
VAGRANT_TMP_RPM="${VAGRANT_TMP_DIR}/vagrant_${VAGRANT_VERSION}.rpm"
VAGRANT_BASE_URL="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}"


install_virtualbox() {
  is_program_installed VBoxManage || \
  {
    sudo pacman update && \
    sudo pacman install --noconfirm ${VAGRANT_VIRTUALBOX_VERSION};
  } || \
  error "Fail to install ${VAGRANT_VIRTUALBOX_VERSION}"
}

_is_vagrant_updated_version() {
  if [[ $(version "${VAGRANT_VERSION}") -ge $(version "2.3.0") ]]; then
    return 0
  else
    return 1
  fi
}

_vagrant_version() {
  if _is_vagrant_updated_version; then
    echo "${VAGRANT_VERSION}-1"
  else
    echo "${VAGRANT_VERSION}"
  fi
}

_vagrant_debian_arch() {
  local arch
  arch=$(uname -m)
  if _is_vagrant_updated_version; then
    if [[ $arch == "x86_64" ]]; then
      arch="amd64"
    fi
  fi
  echo "${arch}"
}

_install_vagrant() {
  local url package version arch
  if pacman -P |grep -q 'dpkg'; then
    version=$(_vagrant_version)
    arch=$(_vagrant_debian_arch)
    url="${VAGRANT_BASE_URL}/vagrant_${version}_${arch}.deb"
    package=${VAGRANT_TMP_DEB}
  else
    version=$(_vagrant_version)
    arch=$(uname -m)
    url="${VAGRANT_BASE_URL}/vagrant_${version}_${arch}.rpm"
    package=${VAGRANT_TMP_RPM}
  fi
  mkdir -p "${VAGRANT_TMP_DIR}" && \
  {
    curl -LfsS ${url} -o ${package} 2>/dev/null || \
    error "Fail to download vagrant ${package} package";
  }
  {
    sudo pacman update && \
    sudo pacman install --noconfirm ${package};
  } || \
  error "Fail to install vagrant ${VAGRANT_VERSION}"
}

install_vagrant() {
  is_program_installed vagrant || \
  _install_vagrant
}

install_pacapt
install_virtualbox
install_vagrant
