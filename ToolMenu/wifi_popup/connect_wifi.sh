#!/bin/bash

SSID="$1"

if [ -z "$SSID" ]; then
    exit 1
fi

# Check if already connected
CURRENT_SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2)
if [ "$CURRENT_SSID" = "$SSID" ]; then
    dunstify -u low -t 3000 "Already connected to $SSID"
    exit 0
fi

# Check if the network is already known (saved connection)
if nmcli con show | grep -q "^$SSID "; then
    # Known network, connect without password
    nmcli dev wifi connect "$SSID"
else
    # Check if security requires password
    SECURITY=$(nmcli -f SSID,SECURITY dev wifi list | grep "$SSID" | head -1 | awk '{print $2}')

    if [[ "$SECURITY" == *"WPA"* ]]; then
        # Prompt for password using rofi
        PASSWORD=$(rofi -dmenu -config ~/.config/niri/eww/widgets/wifi_popup/rofi.rasi -p "Enter password")
        if [ -n "$PASSWORD" ]; then
            nmcli dev wifi connect "$SSID" password "$PASSWORD"
        fi
    else
        nmcli dev wifi connect "$SSID"
    fi
fi
