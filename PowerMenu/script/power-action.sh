#!/usr/bin/env bash

ACTION=$1
STATE_FILE="/tmp/power_action_state"

if [ "$ACTION" = "poweroff" ] || [ "$ACTION" = "reboot" ]; then
  if [ -f "$STATE_FILE" ]; then
    STORED_ACTION=$(cat "$STATE_FILE")
    if [ "$STORED_ACTION" = "$ACTION" ]; then
      rm "$STATE_FILE"
      if [ "$ACTION" = "poweroff" ]; then
        poweroff
      elif [ "$ACTION" = "reboot" ]; then
        reboot
      fi
    else
      echo "$ACTION" >"$STATE_FILE"
      notify-send "Double click to $ACTION"
      (
        sleep 5
        rm -f "$STATE_FILE"
      ) &
    fi
  else
    echo "$ACTION" >"$STATE_FILE"
    notify-send "Double click to $ACTION"
    (
      sleep 5
      rm -f "$STATE_FILE"
    ) &
  fi
fi
