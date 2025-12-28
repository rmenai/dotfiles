#!/usr/bin/env bash

last_status=""
echo "Power adjustment script started"

while true; do
  current_status=$(cat /sys/class/power_supply/ADP0/online)
  if [ "$current_status" != "$last_status" ]; then
    if [ "$current_status" = "0" ]; then
      # On battery (AC adapter offline)
      echo "Switched to battery power - starting battery hypridle config"
      # hyprctl keyword monitor "eDP-1, 1920x1200@60, 0x0, 1"
      pkill hypridle || true
      hypridle -c ~/.config/hypr/hypridle.bat.conf &>/dev/null &
    else
      # On AC power (AC adapter online)
      echo "Switched to AC power - starting AC hypridle config"
      # hyprctl keyword monitor "eDP-1, highres@highrr, 0x0, 1.6"
      pkill hypridle || true
      hypridle -c ~/.config/hypr/hypridle.conf &>/dev/null &
    fi
    last_status="$current_status"
  fi
  sleep 1
done
