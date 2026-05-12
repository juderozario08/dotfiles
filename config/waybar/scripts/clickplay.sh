#!/bin/bash

status="$(playerctl status --format '{{status}}' 2>/dev/null)"
if [ -z $status ]; then
    hyprctl dispatch exec spotify && sleep 2
fi
playerctl play-pause
