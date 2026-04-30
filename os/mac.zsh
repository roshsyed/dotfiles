# Homebrew (sets PATH, MANPATH, INFOPATH)
eval "$(/opt/homebrew/bin/brew shellenv)"

# System away commands
export SYS_LOCK="pmset displaysleepnow"
export SYS_SLEEP="pmset sleepnow"

# OS-specific configs
export TERM_CONFIG="$HOME/.config/ghostty/config"

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
