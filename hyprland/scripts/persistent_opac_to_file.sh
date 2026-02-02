#!/bin/bash
# persistent_opac_to_file.sh
# This script ensures the opacity database file exists

# Make sure the config directory exists
mkdir -p ~/.config/hypr

# Create the file if it doesn't exist
DB_FILE="$HOME/.config/hypr/window_opacity.db"
if [ ! -f "$DB_FILE" ]; then
    touch "$DB_FILE"
    echo "# window_opacity database" >> "$DB_FILE"
    echo "Created $DB_FILE"
else
    echo "$DB_FILE already exists"
fi

