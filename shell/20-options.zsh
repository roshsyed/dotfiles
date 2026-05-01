setopt histignorealldups sharehistory auto_cd

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit

zshaddhistory() {
  emulate -L zsh
  local -a lines=("${(@f)1}")
  (( ${#lines} >= 5 || ${#1} > 1000 )) && return 1
  return 0
}
