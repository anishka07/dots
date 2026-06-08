#!/bin/bash

# macOS 14+ redacts SSID without Location Services.
# To see the actual network name:
#   System Settings → Privacy & Security → Location Services → enable for your terminal app (e.g. Ghostty)

SUMMARY=$(ipconfig getsummary en0 2>/dev/null)
CONNECTED=$(echo "$SUMMARY" | grep "LinkStatusActive : TRUE")
SSID=$(echo "$SUMMARY" | awk '$1 == "SSID" {print $3}')

if [ -z "$CONNECTED" ]; then
  ICON="󰤮"
  LABEL="offline"
elif [ -z "$SSID" ] || [ "$SSID" = "<redacted>" ]; then
  ICON="󰖩"
  LABEL="connected"
else
  ICON="󰖩"
  LABEL="$SSID"
fi

sketchybar --set $NAME icon="$ICON" label="$LABEL"
