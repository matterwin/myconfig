#!/usr/bin/env bash

STEP=0.1
DIR="$1"   # up | down

# Get focused window JSON
WIN_JSON=$(hyprctl -j activewindow)

# Extract opacity (default = 1.0)
CUR=$(echo "$WIN_JSON" | jq -r '.opacity // 1.0')

# Do math
if [ "$DIR" = "down" ]; then
  NEW=$(echo "$CUR - $STEP" | bc -l)
else
  NEW=$(echo "$CUR + $STEP" | bc -l)
fi

# Clamp between 0.1 and 1.0
NEW=$(echo "$NEW" | awk '{
  if ($1 < 0.1) print 0.1;
  else if ($1 > 1.0) print 1.0;
  else printf "%.1f\n", $1
}')

# Apply opacity
hyprctl dispatch opacity "$NEW"

