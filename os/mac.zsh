# Homebrew (sets PATH, MANPATH, INFOPATH)
eval "$(/opt/homebrew/bin/brew shellenv)"

# yubikey-agent SSH socket
export SSH_AUTH_SOCK="$(brew --prefix)/var/run/yubikey-agent.sock"

# opencode (user-local mac install)
export PATH="$HOME/.opencode/bin:$PATH"

# System away commands
export SYS_LOCK="pmset displaysleepnow"
export SYS_SLEEP="pmset sleepnow"

# OS-specific configs
export TERM_CONFIG="$HOME/.config/ghostty/config"
export COMPOSITOR_CONFIG="$HOME/.aerospace.toml"
export COMPOSITOR_RELOAD="aerospace reload-config"

# Extra OMZ plugins consumed by shell/40-plugins.zsh
typeset -ga OS_OMZ_PLUGINS=(macos brew)

# OS-specific aliases applied AFTER OMZ libs (which redefine ll/ls)
os_post_plugins() {
  alias ls='ls -G'
  alias ll='ls -lahG'
}
