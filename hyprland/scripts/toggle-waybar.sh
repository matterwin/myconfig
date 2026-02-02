#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null; then
    # Send toggle signal
    pkill -SIGUSR1 waybar
else
    # Spawn Waybar
    waybar &
fi

