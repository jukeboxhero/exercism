#!/usr/bin/env bash

reverse () {
  length=${#1}
  for (( i=$length-1; i>=0; i-- ))
  do
    rev+="${1:$i:1}";
  done

  echo "$rev";
}

ALPHABET="abcdefghijklmnopqrstuvwxyz"
REVERSE_ALPHA=$( reverse $ALPHABET )

sanitize () {
  local -l sanitized=${1//[[:punct:]]/}
  echo "${sanitized// }"
}

find_char_by_index () {
  current_let=$1

  rest=${ALPHABET#*$current_let}
  char_index=$(( ${#ALPHABET} - ${#rest} - 1 ))
  echo ${REVERSE_ALPHA:$char_index:1}
}

cipher() {
  output=''
  input=$(sanitize "$2")
  length=${#input}

  for (( i=0; i<$length; i++ ))
  do
    if [[ "$1" == "encode" ]]; then
      (( ($i > 0) && ($i % 5) == 0)) && output+=' '
    fi

    current_let="${input:$i:1}"

    [[ $current_let =~ [0-9] ]] && output+=$current_let && continue

    reverse_char=$( find_char_by_index $current_let )
    output+=$reverse_char
  done

  echo "$output"
}

encode () {
  cipher "encode" "$1"
}

decode () {
  cipher "decode" "$1"
}

main () {
  action=$1

  $action "$2"
}

main "$@"
