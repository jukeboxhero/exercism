#!/usr/bin/env bash

main () {
  for c in {a..z}; do
    if [[ "${1^^}" == *"${c^^}"* ]]; then continue; fi
    echo "false"
    return 0
  done
  echo "true"
}

main "$@"
