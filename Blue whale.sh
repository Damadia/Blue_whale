#!/bin/sh
printf '\033c\033]0;%s\a' Blue whale
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Blue whale.x86_64" "$@"
