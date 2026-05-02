# Edit configs
alias ec="$EDITOR \$ZDOTDIR_REPO/custom.zsh"
alias ecz="$EDITOR \$HOME/.zshrc"
alias ect="$EDITOR \$TERM_CONFIG"
alias ece="$EDITOR \$EDITOR_CONFIG"
[[ -n "$COMPOSITOR_CONFIG" ]] && alias ecc="$EDITOR \$COMPOSITOR_CONFIG"
[[ -n "$COMPOSITOR_RELOAD" ]] && alias rcc="$COMPOSITOR_RELOAD"
alias ecg="$EDITOR \$HOME/.gitconfig"
alias ecs="$EDITOR \$HOME/.ssh/config"
alias eca="$EDITOR \$ZDOTDIR_REPO/AGENTS.md"
alias ech="sudoedit /etc/hosts"

# Start apps (only alias if OS provided the var)
[[ -n "$PWD_MGR_START" ]]     && alias pm="$PWD_MGR_START"
[[ -n "$VPN_START" ]]         && alias vpn="$VPN_START"
[[ -n "$IMAGE_EDITOR_START" ]] && alias gimp="$IMAGE_EDITOR_START"

# Idle
alias afk="$SYS_LOCK"
alias zzz="$SYS_SLEEP"

# Misc
alias sc="source \$HOME/.zshrc"
alias grep='grep --color=auto'
# Single quotes intentional: zsh re-expands $EDITOR at alias invocation,
# so changing $EDITOR later (e.g. in custom.zsh) takes effect immediately.
alias vi='$EDITOR'
alias vim='$EDITOR'
alias info="info --vi-keys"
alias nocomment='grep -Ev "^\s*(#|;|$)"'
alias k="kubectl"
alias zsh-plugins-update='for d in ${ZSH_PLUGIN_DIR:-$HOME/.local/share/zsh/plugins}/*/; do echo "Updating ${d:t}..."; git -C "$d" pull --quiet --ff-only || echo "  failed"; done'
alias dotfiles="cd \$ZDOTDIR_REPO"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
