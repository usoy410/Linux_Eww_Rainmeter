#!/bin/bash

# Script to fetch daily inspirational quote from ZenQuotes API
# Runs on boot, checks if it's a new day, fetches if needed

CONFIG_DIR="$HOME/.config/veneer/eww/widgets/QuoteWidget"
QUOTE_FILE="$CONFIG_DIR/quotes/quote.txt"
AUTHOR_FILE="$CONFIG_DIR/quotes/author.txt"
DATE_FILE="$CONFIG_DIR/quotes/last_fetch_date.txt"

# Ensure config and quote directories exist
mkdir -p "$CONFIG_DIR/quotes"

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Check if we already fetched today
if [ -f "$DATE_FILE" ] && [ "$(cat "$DATE_FILE")" = "$TODAY" ]; then
    echo "Quote already fetched today. Skipping."
    exit 0
fi

# Fetch quote from API
RESPONSE=$(curl -fsS --connect-timeout 10 --max-time 20 "https://zenquotes.io/api/random" 2>/dev/null || true)

# Parse response, preferring jq when available
QUOTE=""
AUTHOR=""

if [ -n "$RESPONSE" ]; then
    if command -v jq >/dev/null 2>&1 && echo "$RESPONSE" | jq -e '.[0] | has("q") and has("a")' >/dev/null 2>&1; then
        QUOTE=$(echo "$RESPONSE" | jq -r '.[0].q')
        AUTHOR=$(echo "$RESPONSE" | jq -r '.[0].a')
    else
        QUOTE=$(printf '%s' "$RESPONSE" | sed -n 's/.*"q"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)
        AUTHOR=$(printf '%s' "$RESPONSE" | sed -n 's/.*"a"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -n1)
        QUOTE=$(printf '%s' "$QUOTE" | sed 's/\\"/"/g; s/\\n/ /g')
        AUTHOR=$(printf '%s' "$AUTHOR" | sed 's/\\"/"/g; s/\\n/ /g')
    fi
fi

if [ -n "$QUOTE" ] && [ -n "$AUTHOR" ]; then
    # Write to quote file
    echo "\"$QUOTE\"" > "$QUOTE_FILE"
    echo "$AUTHOR" > "$AUTHOR_FILE"

    # Update date file
    echo "$TODAY" > "$DATE_FILE"

    echo "Fetched new quote: $QUOTE - $AUTHOR"
else
    # Ensure there is always a displayable quote even when API/deps fail.
    if [ ! -s "$QUOTE_FILE" ] || [ ! -s "$AUTHOR_FILE" ]; then
        echo "\"Stay curious, keep building.\"" > "$QUOTE_FILE"
        echo "Veneer" > "$AUTHOR_FILE"
    fi
    echo "Failed to fetch quote or invalid response. Keeping previous quote."
fi
