#!/bin/bash
# while true
# do
#     playerctl -a status --format '{"alt": "{{status}}"}' 2>/dev/null
#     usleep 100000
# done
while true
do
    status="$(playerctl status --format '{{status}}' 2>/dev/null)"
    if [ "$status" == "Playing" ]; then
        echo ""
    else
        echo ""
    fi
    usleep 100000
done
