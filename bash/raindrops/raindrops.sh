#!/usr/bin/env bash
STR=""

main () {
  if (( $1 % 3 == 0 )); then
    STR+="Pling"
  fi

  if (( $1 % 5 == 0)); then
    STR+="Plang"
  fi
  
  if (( $1 % 7 == 0)); then
    STR+="Plong"
  fi

  [[ -z "$STR" ]] && echo "$1" || echo "$STR"
}

main "$@"
