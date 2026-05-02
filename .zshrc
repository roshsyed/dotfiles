typeset -U PATH path  # deduplicates PATH automatically

# Resolve repo dir from this file's location (handles symlink from ~/.zshrc)
ZDOTDIR_REPO="${${(%):-%x}:A:h}"

case "$OSTYPE" in
  darwin*) DOTFILES_OS="mac"   ;;
  linux*)  DOTFILES_OS="linux" ;;
  *) echo "Unsupported OSTYPE: $OSTYPE" >&2 ;;
esac

# OS-specific first: sets PATH, SYS_*, TERM_CONFIG, ZPLUG_HOME, os_extra_plugins
source "$ZDOTDIR_REPO/os/$DOTFILES_OS.zsh"

# Shared shell config (numeric prefix controls load order)
for f in "$ZDOTDIR_REPO"/shell/*.zsh; do
  source "$f"
done

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# === SCRATCH (refactor me) ===
alias free='vm_stat | perl -ne '\''/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-20s %.2f MB\n", "$1:", $2 * $size / 1048576);'\'''
# === END SCRATCH ===
