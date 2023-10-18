#!/bin/bash

SCREEN_RESOLUTION="$(xdpyinfo | grep dimensions | cut -d' ' -f7)"
BGCOLOR="#0F0F0F"
image=$HOME/.local/share/backgrounds/michael_scott.png
convert $image -gravity Center -background \
 $BGCOLOR -extent "$SCREEN_RESOLUTION" RGB:- \
 | i3lock --raw "$SCREEN_RESOLUTION":rgb -c $BGCOLOR -i /dev/stdin
