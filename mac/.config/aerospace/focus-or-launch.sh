#!/usr/bin/env bash
# focus-or-launch.sh <bundle-id> <fallback-workspace> <launch-cmd>...
# If any window of <bundle-id> exists, switch to its workspace and raise it.
# Else switch to <fallback-workspace> and run <launch-cmd>.
set -e

LOG="${HOME}/.cache/aerospace-scripts.log"
mkdir -p "$(dirname "$LOG")"
trap 'echo "[$(date +%FT%T)] $(basename "$0") FAILED: $BASH_COMMAND (exit $?)" >> "$LOG"' ERR

bundle="$1"
ws="$2"
shift 2

read -r win_id ws_of_win < <(aerospace list-windows --monitor all --app-bundle-id "$bundle" --format '%{window-id} %{workspace}' 2>/dev/null | head -1)

if [[ -n "$ws_of_win" ]]; then
  aerospace workspace "$ws_of_win"
  aerospace focus --window-id "$win_id"
else
  aerospace workspace "$ws"
  exec "$@"
fi
