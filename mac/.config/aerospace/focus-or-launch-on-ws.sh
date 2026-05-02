#!/usr/bin/env bash
# focus-or-launch-on-ws.sh <bundle-id> <workspace> <launch-cmd>...
# Switch to <workspace>. If <bundle-id> window exists on <workspace>, focus it.
# Else run <launch-cmd> (new window land on <workspace> since now focused).
set -e

LOG="${HOME}/.cache/aerospace-scripts.log"
mkdir -p "$(dirname "$LOG")"
trap 'echo "[$(date +%FT%T)] $(basename "$0") FAILED: $BASH_COMMAND (exit $?)" >> "$LOG"' ERR

bundle="$1"
ws="$2"
shift 2

aerospace workspace "$ws"

win_id=$(aerospace list-windows --workspace "$ws" --app-bundle-id "$bundle" --format '%{window-id}' 2>/dev/null | head -1)

if [[ -n "$win_id" ]]; then
  aerospace focus --window-id "$win_id"
else
  exec "$@"
fi
