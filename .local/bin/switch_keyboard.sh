#!/bin/bash

# Path to your existing script that changes the keyboard layout
CHANGE_LAYOUT_SCRIPT="~/.local/bin/kbswitch"

# Available layouts
layouts=("english" "swedish")
# Use rofi to select a layout
selected=$(printf '%s\n' "${layouts[@]}" | rofi -dmenu -p "Select keyboard layout:")

# If a layout was selected, change to it
# Convert argument to lowercase
# Switch layout based on argument
case $selected in
    us|en|eng|english)
        ibus engine xkb:us::eng
        echo "Switched to US English layout"
        ;;
    se|sv|swe|swedish)
        ibus engine xkb:se::swe
        echo "Switched to Swedish layout"
        ;;
    *)
        echo "Invalid layout. Use 'us' for English or 'se' for Swedish."
        exit 1
        ;;
esac


