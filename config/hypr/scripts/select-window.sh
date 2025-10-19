#!/bin/bash

clients=$(hyprctl clients -j)

selection=$(echo "${clients}" | jq -r '.[] | select(.mapped == true) | "\(.workspace.name): \(.class): \(.title) | \(.address)"' \
  | fuzzel --match-mode=fzf --width=120 --dmenu --prompt "Select window:")

[ -z "${selection}" ] && exit 0

address=$(echo "${selection}" | awk -F'|' '{print $2}' | tr -d ' ')

hyprctl dispatch focuswindow "address:${address}"
