#!/usr/bin/env bash

strip_whitespace() {
  echo "$(sed -e 's/[[:space:]]*$//' <<<${1})";
}

silence() { [[ "$1" =~ ^[[:space:]]*$ ]]; }
yelling() { [[ "${1^^}" == $1 ]] && $(has_letters "$1"); }
question() { [[ "${1: -1}" == "?" ]]; }
has_letters() { [[ $1 =~ [A-Za-z]  ]]; }

main () {
  statement=$(strip_whitespace "$1")

  $(silence "$statement") && echo "Fine. Be that way!" && return 0;
  $(yelling "$statement") && $(question "$statement") && $(has_letters "$statement") && echo "Calm down, I know what I'm doing!" && return 0;
  $(question "$statement") && echo "Sure." && return 0;
  $(yelling "$statement") && echo "Whoa, chill out!" && return 0;

  echo "Whatever."
}

main "$@"
