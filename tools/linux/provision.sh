#!/usr/bin/env bash
set -o pipefail

# shellcheck source=tools/helpers/log.sh
source ../helpers/log.sh
# shellcheck source=tools/helpers/system.sh
source ../helpers/system.sh
# shellcheck source=tools/helpers/pacapt.sh
source ../helpers/pacapt.sh

VAGRANT_VERSION='2.2.19'
VAGRANT_VIRTUALBOX_VERSION='virtualbox'
VAGRANT_TMP_DIR='/tmp/downloads'
VAGRANT_TMP_DEB="${VAGRANT_TMP_DIR}/vagrant_${VAGRANT_VERSION}.deb"
VAGRANT_TMP_RPM="${VAGRANT_TMP_DIR}/vagrant_${VAGRANT_VERSION}.rpm"
VAGRANT_URL_DEB="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_$(uname -m).deb"
VAGRANT_URL_RPM="https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_$(uname -m).rpm"


install_virtualbox() {
  is_program_installed VBoxManage || \
  {
    sudo pacman update && \
    sudo pacman install --noconfirm ${VAGRANT_VIRTUALBOX_VERSION};
  } || \
  error "Fail to install ${VAGRANT_VIRTUALBOX_VERSION}"
}

_install_vagrant() {
  local url package
  if pacman -P |grep -q 'dpkg'; then
    url=${VAGRANT_URL_DEB}
    package=${VAGRANT_TMP_DEB}
  else
    url=${VAGRANT_URL_RPM}
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
