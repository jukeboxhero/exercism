#!/usr/bin/env bash

main () {
  validate $1
  process_input $1
}

validate () {
  regex='^[A-Za-z]+$'
  if [[ $1 =~ $regex ]]; then
    return 0
  elif (( $1 <= 0 || $1 > 64 )); then
    echo "Error: invalid input"
    exit 1
  fi
}

process_input () {
  if [[ $1 = "total" ]]; then
    display_total_grains
  fi
  display_current_square $1
}

display_current_square () {
  echo  "2 ^ ($1 - 1)" | bc
  exit 0
}

display_total_grains () {
  echo "(2 ^ 64) - 1" | bc
  exit 0
}

main "$@"
