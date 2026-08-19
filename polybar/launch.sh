#!/usr/bin/env bash

# polybar-msg cmd quit
killall -q polybar
# polybar

# Launch bar
echo "---" | tee -a /tmp/polybar.log

polybar bar --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown

echo "Bars launched..."
