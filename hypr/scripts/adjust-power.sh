#!/usr/bin/env bash

last_status=""

while true; do
  current_status=$(cat /sys/class/power_supply/BAT0/status)

  if [ "$current_status" != "$last_status" ]; then
    if [ "$current_status" = "Discharging" ]; then
      hyprctl keyword monitor "eDP-1, 1920x1200@60, 0x0, 1"
      pkill hypridle || true
      hypridle -c ~/.config/hypr/hypridle.power.conf &>/dev/null &
    else
      hyprctl keyword monitor "eDP-1, highres@highrr, 0x0, 1.6"
      pkill hypridle || true
      hypridle -c ~/.config/hypr/hypridle.conf &>/dev/null &
    fi

    last_status="$current_status"
  fi

  sleep 1
done
