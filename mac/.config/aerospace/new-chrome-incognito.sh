#!/usr/bin/env bash
set -e

LOG="${HOME}/.cache/aerospace-scripts.log"
mkdir -p "$(dirname "$LOG")"
trap 'echo "[$(date +%FT%T)] $(basename "$0") FAILED: $BASH_COMMAND (exit $?)" >> "$LOG"' ERR

osascript -e 'tell application "Google Chrome" to make new window with properties {mode:"incognito"}'
osascript -e 'tell application "Google Chrome" to activate'
