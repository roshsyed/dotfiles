setopt histignorealldups sharehistory auto_cd extended_glob no_beep interactive_comments

HISTSIZE=50000
SAVEHIST=50000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
mkdir -p "${HISTFILE:h}"
[[ -f "$HOME/.zsh_history" && ! -f "$HISTFILE" ]] && mv "$HOME/.zsh_history" "$HISTFILE"

zshaddhistory() {
  emulate -L zsh
  local -a lines=("${(@f)1}")
  (( ${#lines} >= 5 || ${#1} > 1000 )) && return 1
  return 0
}
