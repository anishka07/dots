#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep -c "AC Power")

if [ "$CHARGING" -gt 0 ]; then
  ICON="󰂄"
  COLOR=0xff9ece6a
elif [ "$PERCENTAGE" -le 20 ]; then
  ICON="󰁺"
  COLOR=0xfff7768e
elif [ "$PERCENTAGE" -le 50 ]; then
  ICON="󰁼"
  COLOR=0xffe0af68
else
  ICON="󰁹"
  COLOR=0xff9ece6a
fi

sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
