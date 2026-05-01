export PATH="$PATH:/opt/nvim/bin:/usr/local/go/bin:/usr/local/opencode/bin"

# App starts
export PWD_MGR_START="flatpak run com.bitwarden.desktop"
export VPN_START="/opt/windscribe/Windscribe"
export IMAGE_EDITOR_START="snap run gimp"

# System away commands
export SYS_LOCK="swaylock --color 000000"
export SYS_SLEEP="systemctl suspend"

# OS-specific configs
export TERM_CONFIG="$HOME/.config/foot/foot.ini"
export COMPOSITOR_CONFIG="$HOME/.config/sway/config"
export COMPOSITOR_RELOAD="swaymsg reload"

# zplug install location
export ZPLUG_HOME="/usr/share/zplug"

# OS-specific aliases (ls flags differ)
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'

# Extra zplug plugins, called from shell/40-plugins.zsh
os_extra_plugins() {
  zplug "ohmyzsh/ohmyzsh", use:"plugins/command-not-found/command-not-found.plugin.zsh"
}
