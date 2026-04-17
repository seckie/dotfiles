#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
printf "\033[1;34m%s:%s %s\033[0m" "$(hostname -s)" "$cwd" "$(whoami)"
