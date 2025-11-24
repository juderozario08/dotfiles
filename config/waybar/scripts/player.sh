#!/bin/bash

name=$(playerctl metadata -f '{{title}} - {{artist}}')

# Output JSON to Waybar
echo "{
  \"status\": \"${status}\",
  \"name\": \"${name}\"
}" | jq --unbuffered --compact-output
