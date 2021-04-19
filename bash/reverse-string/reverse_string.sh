#!/usr/bin/env bash
set -o noglob
length=${#1}

main () {
  for (( i=$length; i>=0; i-- ))
  do
    reverse+="${1:$i:1}";
  done

  echo "$reverse";
}

main "$@"
