#!/bin/bash

# This script finds the most recently focused floating window and brings it to front

# Get all floating windows with their focusHistoryID
# Skip currently focused windows
id=$(hyprctl clients | awk '
  /^Window/ {win=$2}
  /^floating:/ {floating=$2}
  /^focusHistoryID:/ {fhid=$2}
  /^$/ {
    if(floating==1 && fhid!=0) {print fhid, win}
    win=""; floating=""; fhid=""
  }
' | sort -nr | head -n1 | awk '{print $2}')

# Debug print
echo "Switching to floating window ID: $id"

# Focus it
[ -n "$id" ] && hyprctl dispatch windowfocus "$id"

# Raise it
[ -n "$id" ] && hyprctl dispatch alterzorder "$id" +1

