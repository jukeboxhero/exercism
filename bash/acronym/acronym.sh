#!/usr/bin/env bash
set -o noglob

main () {
  local input=${1//[-_*]/ }
  local output=""
  for word in $input; do
    output+="${word:0:1}"
  done
  echo "${output^^}"
}

main "$@"
