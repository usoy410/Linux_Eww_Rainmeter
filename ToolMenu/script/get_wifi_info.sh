#!/bin/sh

# Prints wifi name and icon as: <name>|<icon>

if ! command -v nmcli >/dev/null 2>&1; then
    echo "Wi-Fi: N/A|WIFI"
    exit 0
fi

WIFI_STATE=$(nmcli -t -f WIFI g 2>/dev/null)
if [ "$WIFI_STATE" != "enabled" ]; then
    echo "Wi-Fi: Off|WIFI_OFF"
    exit 0
fi

SSID=$(nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2; exit}')
if [ -n "$SSID" ]; then
    echo "$SSID|WIFI_ON"
else
    echo "Wi-Fi: Disconnected|WIFI_OFF"
fi
