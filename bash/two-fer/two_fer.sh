#!/usr/bin/env bash
main () {
  local subject=${1:-you};
  echo "One for $subject, one for me."
}

main "$@"
