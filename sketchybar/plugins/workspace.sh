#!/bin/bash

FOCUSED=$(aerospace list-workspaces --focused)

if [ "$FOCUSED" = "${NAME#ws.}" ]; then
  sketchybar --set $NAME \
    background.color=0xff7aa2f7 \
    background.border_width=0 \
    background.drawing=on \
    icon.color=0xff16161d
else
  sketchybar --set $NAME \
    background.color=0x00000000 \
    background.border_width=0 \
    background.drawing=on \
    icon.color=0xff545c7e
fi
