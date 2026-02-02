#!/bin/bash
# usage: ./opacity.sh 0.8

# get focused window address
# addr=$(hyprctl activewindow -j | jq -r '.address')
# addr="address:$addr"

# # set opacity
# hyprctl dispatch setprop "$addr" opacity "$1"


#!/bin/bash
# decreases opacity by 0.1

#!/bin/bash

# get the focused window's address
addr=$(hyprctl activewindow -j | jq -r '.address')
addr="address:$addr"

# get the opacity
cur=$(hyprctl getprop "$addr" opacity | awk '{print $2}')
# send notification
if [ -z "$cur" ] || [ "$cur" = "null" ]; then
    notify-send "Opacity" "Opacity is null (not set)"
else
    notify-send "Opacity" "$cur"
fi

