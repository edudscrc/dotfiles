
#!/bin/bash

TEMPERATURE=$(busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | awk '{print $2}')

PERCENT=$(awk "BEGIN { printf \"%d\", $TEMPERATURE / 100 }")

FILLED=$((PERCENT / 10))
EMPTY=$((10 - FILLED))

BAR=""
for ((i = 0; i < FILLED; i++)); do BAR+="▮"; done
for ((i = 0; i < EMPTY; i++)); do BAR+="▯"; done

echo "{\"text\": \" $BAR\", \"tooltip\": \"Temperature: ${PERCENT}%\", \"class\": \"custom-wl-gammarelay-temperature\"}"