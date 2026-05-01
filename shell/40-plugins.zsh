ZSH_PLUGIN_DIR="${ZSH_PLUGIN_DIR:-$HOME/.local/share/zsh/plugins}"

__plugin_clone() {
  local name="$1" url="$2"
  [[ -d "$ZSH_PLUGIN_DIR/$name" ]] && return 0
  command -v git >/dev/null || { echo "git required for plugin install" >&2; return 1; }
  echo "Cloning $name..."
  git clone --depth=1 --quiet "$url" "$ZSH_PLUGIN_DIR/$name"
}

mkdir -p "$ZSH_PLUGIN_DIR"

__plugin_clone ohmyzsh                      https://github.com/ohmyzsh/ohmyzsh
__plugin_clone zsh-completions              https://github.com/zsh-users/zsh-completions
__plugin_clone zsh-autosuggestions          https://github.com/zsh-users/zsh-autosuggestions
__plugin_clone zsh-syntax-highlighting      https://github.com/zsh-users/zsh-syntax-highlighting
__plugin_clone zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search
__plugin_clone fzf                          https://github.com/junegunn/fzf
__plugin_clone aphrodite-terminal-theme     https://github.com/win0err/aphrodite-terminal-theme

# OMZ env consumed by libs + plugins
export ZSH="$ZSH_PLUGIN_DIR/ohmyzsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
mkdir -p "$ZSH_CACHE_DIR/completions"

# completions on fpath BEFORE compinit
fpath=("$ZSH_PLUGIN_DIR/zsh-completions/src" "$ZSH/plugins" $fpath)

# compinit must run before sourcing OMZ libs/plugins (they call compdef)
autoload -Uz compinit
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# OMZ core libs (async, handlers, key-bindings, theme-and-appearance, ...)
for f in "$ZSH/lib/"*.zsh; do
  source "$f"
done

# OMZ plugins: shared + OS-specific (OS file populates OS_OMZ_PLUGINS)
typeset -ga _omz_plugins=(git sudo ${OS_OMZ_PLUGINS[@]})
for p in "${_omz_plugins[@]}"; do
  [[ -f "$ZSH/plugins/$p/$p.plugin.zsh" ]] && source "$ZSH/plugins/$p/$p.plugin.zsh"
done

# Theme
source "$ZSH_PLUGIN_DIR/aphrodite-terminal-theme/aphrodite.zsh-theme"

# fzf keybindings + completion (vendored scripts, no install step needed)
[[ -f "$ZSH_PLUGIN_DIR/fzf/shell/key-bindings.zsh" ]] && source "$ZSH_PLUGIN_DIR/fzf/shell/key-bindings.zsh"
[[ -f "$ZSH_PLUGIN_DIR/fzf/shell/completion.zsh"   ]] && source "$ZSH_PLUGIN_DIR/fzf/shell/completion.zsh"

# Autosuggestions before syntax-highlighting (recommended order)
source "$ZSH_PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

# syntax-highlighting must come before history-substring-search
source "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZSH_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh"

# OS hook to override anything OMZ libs clobbered (e.g. ls/ll)
typeset -f os_post_plugins > /dev/null && os_post_plugins
