#!/usr/bin/env bash

WIN=$(hyprctl activewindow | grep -oP '(?<=handle: )\d+')

# monitor size
# read X Y W H TRANSFORM <<< $(hyprctl monitors -j | jq -r '
#     .[] | select(.focused==true) | "\(.x) \(.y) \(.width) \(.height) \(.transform)"')

# workspace 
read X Y W H TRANSFORM <<< $(hyprctl monitors -j | jq -r '
    .[] | select(.focused==true) | "\(.workarea.x // .x) \(.workarea.y // .y) \(.workarea.width // .width) \(.workarea.height // .height) \(.transform)"')

# Adjust width/height based on transform
case $TRANSFORM in
    0|2|4|6)
        # normal or 180 / flipped versions -> no swap needed
        ;;
    1|3|5|7)
        # 90 or 270 degrees -> swap W/H
        TMP=$W
        W=$H
        H=$TMP
        ;;
esac

hyprctl dispatch resizeactive exact $W $H
hyprctl dispatch centerwindow

# notify-send "Maximized Floating Window" "X:$X Y:$Y W:$W H:$H Transform:$TRANSFORM"
