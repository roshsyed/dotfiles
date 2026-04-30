# Edit configs
alias ec="$EDITOR \$HOME/.zshrc"
alias ect="$EDITOR \$TERM_CONFIG"
alias ece="$EDITOR \$EDITOR_CONFIG"
[[ -n "$COMPOSITOR_CONFIG" ]] && alias ecc="$EDITOR \$COMPOSITOR_CONFIG"

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
alias vi='$EDITOR'
alias vim='$EDITOR'
alias info="info --vi-keys"
alias nocomment='grep -Ev "^\s*(#|;|$)"'
alias k="kubectl"
