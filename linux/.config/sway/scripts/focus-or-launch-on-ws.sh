#!/usr/bin/env bash
# focus-or-launch-on-ws.sh <app-id> <workspace> [launch-cmd...]
# Switch to <workspace>. If <app-id> window exists on <workspace>, focus it.
# Else run <launch-cmd> (defaults to <app-id>) — sway places new window on
# the focused workspace.
set -e

LOG="${HOME}/.cache/sway-scripts.log"
mkdir -p "$(dirname "$LOG")"
trap 'echo "[$(date +%FT%T)] $(basename "$0") FAILED: $BASH_COMMAND (exit $?)" >> "$LOG"' ERR

app_id="$1"
ws="$2"
shift 2
[ "$#" -eq 0 ] && set -- "$app_id"

swaymsg "workspace number $ws" >/dev/null

result=$(swaymsg -r "[app_id=\"$app_id\" workspace=\"$ws\"] focus" 2>/dev/null || echo "[]")

if [ "$result" = "[]" ]; then
  exec "$@"
fi
