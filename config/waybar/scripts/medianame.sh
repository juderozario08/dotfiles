#!/bin/bash

while true
do
    if [ -z "$(playerctl metadata 2>/dev/null)" ]; then
        echo 'Media'
    else
        media="$(playerctl metadata --format '{{artist}} - {{title}}')"
        if [ "${#media}" -gt 48 ]; then
            first26="${media:0:48}"
            echo "${first26}..."
        else
            echo $media
        fi
    fi
    usleep 200000
done
