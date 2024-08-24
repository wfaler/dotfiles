#!/bin/bash

# Define the options
options=("Lock screen" "Logout" "Reboot" "Shutdown")

# Show the options in rofi and get the selected one
selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -p "Power menu")

# Perform the selected action
case "$selected" in
    "Lock screen")
        i3lock && xset dpms force off
       # i3lock -c 000000  # You can customize this command
        ;;
    "Logout")
        i3-msg exit
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
esac
