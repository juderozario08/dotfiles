#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        echo $m
        MONITOR=$m polybar --reload i3 2>&1 | tee -a /tmp/polybar.log & disown
    done
else
    polybar --reload i3 2>&1 | tee -a /tmp/polybar.log & disown
fi
