if [[ ! -f "$ZPLUG_HOME/init.zsh" ]]; then
  echo "zplug not found at $ZPLUG_HOME — skipping plugins" >&2
  return 0
fi
source "$ZPLUG_HOME/init.zsh"

# OMZ core libs first (needed for async, handlers, etc.)
zplug "ohmyzsh/ohmyzsh", use:"lib/*.zsh"

# OMZ plugins (cross-platform)
zplug "ohmyzsh/ohmyzsh", use:"plugins/git/git.plugin.zsh"
zplug "ohmyzsh/ohmyzsh", use:"plugins/sudo/sudo.plugin.zsh"

# Non-OMZ plugins
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf"

# Theme
zplug "win0err/aphrodite-terminal-theme", as:theme, use:"aphrodite.zsh-theme"

# OS-specific plugins (defined in os/$OS.zsh)
typeset -f os_extra_plugins > /dev/null && os_extra_plugins

# Install/load
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then echo; zplug install; fi
fi
zplug load
