setopt histignorealldups sharehistory

HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history

autoload -Uz compinit
compinit
