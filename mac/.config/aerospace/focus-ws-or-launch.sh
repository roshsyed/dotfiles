#!/usr/bin/env bash
# focus-ws-or-launch.sh <workspace> <launch-cmd>...
# Switch to <workspace>. If it has no windows, run <launch-cmd>
# (which will spawn the new window into the now-focused workspace).
set -e

LOG="${HOME}/.cache/aerospace-scripts.log"
mkdir -p "$(dirname "$LOG")"
trap 'echo "[$(date +%FT%T)] $(basename "$0") FAILED: $BASH_COMMAND (exit $?)" >> "$LOG"' ERR

ws="$1"
shift

aerospace workspace "$ws"

count=$(aerospace list-windows --workspace "$ws" --count 2>/dev/null || echo 0)
if [[ "$count" == "0" ]]; then
  exec "$@"
fi
