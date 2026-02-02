#!/usr/bin/env bash

FILE=$(zenity --file-selection --save \
  --title="Save Screenshot" \
  --filename="$HOME/Pictures/screenshot.png")

[ -z "$FILE" ] && exit 0

hyprshot -m region -o "$FILE"

