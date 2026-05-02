# dotfiles

Personal zsh + config files. Cross-platform (Linux, macOS).

## Install

```sh
./install.sh
```

Symlinks `~/.zshrc` and any platform-specific files from `linux/` or `mac/` into `$HOME`. Existing files are backed up to `*.bak`. Idempotent.

## Plugin updates

```sh
zsh-plugins-update
```

Pulls latest for all plugins under `${ZSH_PLUGIN_DIR:-~/.local/share/zsh/plugins}`.

## Local scratch

`custom.zsh` at repo root is gitignored and sourced last from `.zshrc`. Use it for transient/dev/test config that shouldn't ship.

## Requirements

- `zsh`
- `git` (used for first-run plugin clones)
- `nvim` (optional, falls back to `vi`)
- `fzf` (used by `fcd` and the fzf plugin's keybindings)

## Contributing / structure

See `AGENTS.md`.

## Known limitations

- macOS section assumes Apple Silicon Homebrew (`/opt/homebrew`). Intel Macs need `os/mac.zsh` adjusted.
