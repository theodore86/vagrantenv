#!/usr/bin/env bash
# https://github.com/icy/pacapt

PACAPT_URL='https://github.com/icy/pacapt/raw/ng/pacapt'
PACAPT=$(basename $PACAPT_URL)
PACAPT_DOWNLOAD_DIR='/usr/local/bin'
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=tools/helpers/log.sh
source ${CWD}/log.sh
# shellcheck source=tools/helpers/system.sh
source ${CWD}/system.sh

_download_pacapt() {
  sudo curl -LfsS ${PACAPT_URL} -o ${PACAPT_DOWNLOAD_DIR}/${PACAPT} 2>/dev/null \
    || error "Fail to download ${program} from ${PACAPT_URL}"
}


_install_pacapt() {
  local program
  program='pacman'
  sudo chmod 0755 ${PACAPT_DOWNLOAD_DIR}/${PACAPT} || \
    error "Fail to change ${PACAPT} permissions"
  sudo ln -sv ${PACAPT_DOWNLOAD_DIR}/${PACAPT} ${PACAPT_DOWNLOAD_DIR}/${program} || \
    error "Fail to symlink ${PACAPT} to ${program}"
  info "Successfully installed ${program} under ${PACAPT_DOWNLOAD_DIR}"
}


install_pacapt() {
  is_program_installed pacman || \
  { _download_pacapt && _install_pacapt; }
}
