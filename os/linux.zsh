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

# Extra OMZ plugins consumed by shell/40-plugins.zsh
typeset -ga OS_OMZ_PLUGINS=(command-not-found)

# OS-specific aliases applied AFTER OMZ libs (which redefine ll/ls)
os_post_plugins() {
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
}
