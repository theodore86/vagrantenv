#!/usr/bin/env bash

error() {
  echo >&2 ":: [Error]: $*"
  exit 1
}


warn() {
  echo >&2 ":: [Warning]: $*"
  return 0
}


info() {
  echo >&1 ":: [Info]: $*"
  return 0
}
