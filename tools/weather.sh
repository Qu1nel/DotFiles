#!/usr/bin/env bash

invalid_input() {
    echo "invalid_input '$@'. Must be one argument!"
    exit 1
}

[[ "$#" -ge 2 ]] && invalid_input $@

city=$1

curl -4 wttr.in/$city
