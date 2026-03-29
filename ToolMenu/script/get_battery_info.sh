#!/bin/sh

# Prints battery percent and icon as: <tooltip>|<icon>
# Falls back gracefully when battery data is unavailable.

if command -v upower >/dev/null 2>&1; then
    BATTERY_PATH=$(upower -e 2>/dev/null | grep -m1 BAT || true)
    if [ -n "$BATTERY_PATH" ]; then
        PERCENT=$(upower -i "$BATTERY_PATH" 2>/dev/null | awk '/percentage/ {gsub("%", "", $2); print $2; exit}')
        STATE=$(upower -i "$BATTERY_PATH" 2>/dev/null | awk '/state/ {print $2; exit}')
    fi
fi

if [ -z "${PERCENT:-}" ] && command -v acpi >/dev/null 2>&1; then
    PERCENT=$(acpi -b 2>/dev/null | awk -F', ' 'NR==1 {gsub("%", "", $2); print $2}')
    STATE=$(acpi -b 2>/dev/null | awk -F', ' 'NR==1 {print tolower($1)}' | awk -F': ' '{print $2}')
fi

if [ -z "${PERCENT:-}" ]; then
    echo "Battery: N/A|?"
    exit 0
fi

if [ "${STATE:-}" = "charging" ] || [ "${STATE:-}" = "fully-charged" ]; then
    ICON="+"
else
    ICON="BAT"
fi

echo "Battery: ${PERCENT}%|${ICON}"
