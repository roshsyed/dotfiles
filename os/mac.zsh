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

# zplug install location
export ZPLUG_HOME="/opt/homebrew/opt/zplug"

# OS-specific aliases (BSD ls)
alias ls='ls -G'
alias ll='ls -lahG'

# Extra zplug plugins, called from shell/40-plugins.zsh
os_extra_plugins() {
  zplug "ohmyzsh/ohmyzsh", use:"plugins/macos/macos.plugin.zsh"
  zplug "ohmyzsh/ohmyzsh", use:"plugins/brew/brew.plugin.zsh"
}
