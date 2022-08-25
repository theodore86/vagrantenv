#!/usr/bin/env bash
#
# Ansible installation through PIP using shell provisioner
#
set -e

[[ -n $DEBUG ]] && set -x


_error() {
  echo >&2 ":: [Error]: $*"
  exit 1
}


_install_python3() {
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
      python3-setuptools \
      python3-pip \
      python3-dev
}


_install_ansible() {
    local requirements="$1"
    pip3 install --upgrade -r "$requirements"
    ansible --version
}


main() {
   _install_python3 || _error 'Python3 installation failed'
   local requirements="$*"
   requirements=$(echo $requirements | sed 's/ /\//g')
   [[ -f $requirements ]] || _error "Ansible requirements file: '$requirements' is missing"
   _install_ansible "$requirements" || _error 'Ansible installation failed'
}

main "$*"
