#!/usr/bin/env bash

main () {
  validate $1

  str=${1//[[:blank:]]/}
  sum=0
  rev_index=0
  for (( i=((${#str} - 1)); i>=0; i--))
  do
    coded=$(coded_char "${str:i:1}" $rev_index)
    rev_index=$(( rev_index + 1 ))
    sum=$(( coded + sum ))
  done

  (( $sum % 10 == 0 )) && echo "true" && return 0
  echo "false"
}

validate() {
  if echo $1 | grep -vq '^[[:digit:]]*$'; then
    echo "false" && exit 0
  fi

  if (( ${#1} > 1 )); then
    return 0
  else
    echo "false" && exit 0
  fi
}

coded_char () {
  char=$1
  if (( $2 % 2 > 0)); then
    double=$(( char * 2 ))
    if (( $double > 9 )); then double=$(( double - 9)); fi;
    echo $double
  else
    echo $char
  fi
}

main "$@"
