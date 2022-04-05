#!/usr/bin/env bash

is_program_installed() {
  local _return cmd
  cmd="$1"
  _return=1
  command -v "$cmd" >/dev/null && _return=0
  return ${_return}
}

get_ostype() {
  local _ostype ostype
  _ostype=$(uname)
  case ${_ostype} in
      Linux)
        ostype='linux'
        ;;
      Darwin)
        ostype='darwin'
        ;;
      *)
        ostype='unknown'
        ;;
  esac
  echo ${ostype}
}
