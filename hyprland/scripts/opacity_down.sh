#!/bin/bash
# Decrease opacity of focused window by 0.1 using the persistent DB

DB_FILE="$HOME/.config/hypr/window_opacity.db"
STEP=0.05
MIN_OPACITY=0.1

# ensure DB exists
mkdir -p "$(dirname "$DB_FILE")"
touch "$DB_FILE"

# get focused window address
addr=$(hyprctl activewindow -j | jq -r '.address')
full_addr="address:$addr"

# check if the window exists in DB, if not initialize it
if ! grep -q "^$full_addr=" "$DB_FILE"; then
    echo "$full_addr=1.0" >> "$DB_FILE"
    cur=1.0
else
    # read current opacity from DB
    cur=$(grep "^$full_addr=" "$DB_FILE" | cut -d '=' -f2)
fi

# decrease and clamp
new=$(awk "BEGIN{v=$cur-$STEP; if(v<$MIN_OPACITY) v=$MIN_OPACITY; print v}")

# write back to file (replace the old line)
sed -i "s|^$full_addr=.*|$full_addr=$new|" "$DB_FILE"

# apply to Hyprland
hyprctl dispatch setprop "$full_addr" opacity "$new"

# optional notification
# notify-send "Opacity" "$new"

