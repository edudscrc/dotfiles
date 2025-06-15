#!/bin/bash

BRIGHTNESS=$(busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Brightness | awk '{print $2}')

PERCENT=$(awk "BEGIN { printf \"%d\", $BRIGHTNESS * 100 }")

FILLED=$((PERCENT / 10))
EMPTY=$((10 - FILLED))

BAR=""
for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

echo "{\"text\": \"󰃠 $BAR\", \"tooltip\": \"Brightness: ${PERCENT}%\", \"class\": \"custom-wl-gammarelay-brightness\"}"