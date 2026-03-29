#!/bin/sh

# Return a Nerd Font battery icon based on charge state/percentage.

BATTERY_PATH="/org/freedesktop/UPower/devices/battery_BAT0"

if ! command -v upower >/dev/null 2>&1; then
  echo "󰂃"
  exit 0
fi

PERCENTAGE=$(upower -i "$BATTERY_PATH" 2>/dev/null | awk '/percentage/ {gsub("%", "", $2); print $2; exit}')
STATE=$(upower -i "$BATTERY_PATH" 2>/dev/null | awk '/state/ {print $2; exit}')

if [ -z "$PERCENTAGE" ]; then
  echo "󰂃"
  exit 0
fi

if [ "$STATE" = "charging" ]; then
  echo "󰂄"
elif [ "$STATE" = "fully-charged" ]; then
  echo "󰁹"
elif [ "$PERCENTAGE" -ge 90 ]; then
  echo "󰁹"
elif [ "$PERCENTAGE" -ge 80 ]; then
  echo "󰂂"
elif [ "$PERCENTAGE" -ge 70 ]; then
  echo "󰂁"
elif [ "$PERCENTAGE" -ge 60 ]; then
  echo "󰂀"
elif [ "$PERCENTAGE" -ge 50 ]; then
  echo "󰁿"
elif [ "$PERCENTAGE" -ge 40 ]; then
  echo "󰁾"
elif [ "$PERCENTAGE" -ge 30 ]; then
  echo "󰁽"
elif [ "$PERCENTAGE" -ge 20 ]; then
  echo "󰁼"
elif [ "$PERCENTAGE" -ge 10 ]; then
  echo "󰁻"
else
  echo "󰁺"
fi
