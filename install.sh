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

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        return 0
    fi

    if [ -L "$dest" ]; then
        rm "$dest"
    elif [ -e "$dest" ]; then
        if [ -e "${dest}.bak" ]; then
            echo "  ERROR: ${dest}.bak already exists. Resolve manually." >&2
            exit 1
        fi
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
    while IFS= read -r -d '' file; do
        rel="${file#./}"
        link_file "$PLATFORM_DIR/$rel" "$HOME/$rel"
    done < <(find . -type f -print0)
fi

echo "Done."
