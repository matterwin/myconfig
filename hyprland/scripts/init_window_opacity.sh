#!/bin/bash
# init_window_opacity.sh
# Ensure the focused window has an entry in the opacity file, default to 1.0

DB_FILE="$HOME/.config/hypr/window_opacity.db"

# make sure file exists
mkdir -p "$(dirname "$DB_FILE")"
touch "$DB_FILE"

# get focused window address
addr=$(hyprctl activewindow -j | jq -r '.address')
full_addr="address:$addr"

# check if this window is already in the file
if ! grep -q "^$full_addr=" "$DB_FILE"; then
    # add it with default opacity 1.0
    echo "$full_addr=1.0" >> "$DB_FILE"
    
    # set opacity in Hyprland
    hyprctl dispatch setprop "$full_addr" opacity 1.0
    
    echo "Initialized $full_addr with opacity 1.0"
else
    echo "$full_addr already initialized"
fi

