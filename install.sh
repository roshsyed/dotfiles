#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Detect platform
case "$(uname -s)" in
    Linux)  PLATFORM="linux" ;;
    Darwin) PLATFORM="mac" ;;
    *)      echo "Unsupported platform: $(uname -s)" >&2; exit 1 ;;
esac

echo "Installing dotfiles for $PLATFORM..."

link_file() {
    local src="$1"
    local dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "  Backing up $dest -> ${dest}.bak"
        mv "$dest" "${dest}.bak"
    fi

    ln -s "$src" "$dest"
    echo "  $dest -> $src"
}

# 1. Common entry: ~/.zshrc -> repo .zshrc (sources shell/ + os/$PLATFORM.zsh)
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# 2. Platform-specific dotfiles (e.g. ~/.config/foot/foot.ini on linux).
#    Skipped silently if the platform dir doesn't exist or has no files.
PLATFORM_DIR="$DOTFILES_DIR/$PLATFORM"
if [ -d "$PLATFORM_DIR" ]; then
    cd "$PLATFORM_DIR"
    find . -type f | while read -r file; do
        rel="${file#./}"
        link_file "$PLATFORM_DIR/$rel" "$HOME/$rel"
    done
fi

echo "Done."
