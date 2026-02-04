#!/usr/bin/env bash

DIRECTION=$1
WSID=$(hyprctl activewindow -j 2>/dev/null | jq -r '.workspace.id')
LAYOUT=$(hyprctl workspaces -j 2>/dev/null | jq -r ".[] | select(.id == $WSID) | .tiledLayout")

# Default to scrolling if no window or layout found
if [[ -z "$LAYOUT" ]] || [[ "$LAYOUT" == "null" ]]; then
    LAYOUT="scrolling"
fi

if [[ "$LAYOUT" == "scrolling" ]]; then
    if [[ "$DIRECTION" == "l" ]]; then
        hyprctl dispatch layoutmsg "move -col"
    elif [[ "$DIRECTION" == "r" ]]; then
        hyprctl dispatch layoutmsg "move +col"
    fi
else
    hyprctl dispatch movefocus "$DIRECTION"
fi
