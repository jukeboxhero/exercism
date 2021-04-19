#!/usr/bin/env bash

main () {
  hamming_distance=0
  dna_strand_1=$1
  dna_strand_2=$2

  if [ "$#" -ne 2 ]; then
    echo "Usage: hamming.sh <string1> <string2>" && return 1
  fi

  if (( ${#dna_strand_1} != ${#dna_strand_2} )); then
    echo "left and right strands must be of equal length" && return 1
  fi

  for (( i=0; i<${#dna_strand_1}; i++ )); do
    [[ ${dna_strand_1:$i:1} != "${dna_strand_2:$i:1}" ]] && (( hamming_distance++ ))
  done
  echo "$hamming_distance"
}
main "$@"
