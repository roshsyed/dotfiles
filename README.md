# dotfiles

Personal zsh + config files. Cross-platform (Linux, macOS).

## Install

```sh
./install.sh
```

Symlinks `~/.zshrc` to `.zshrc` and any platform-specific files from `linux/` or `mac/` into `$HOME`. Existing files are backed up to `*.bak`. Re-running is idempotent — symlinks already pointing at the repo are left alone.

## Layout

```
.zshrc            # entry point, sourced as ~/.zshrc
shell/            # cross-platform config (sourced in order by filename)
  00-exports.zsh
  10-functions.zsh
  20-options.zsh
  30-aliases.zsh
  40-plugins.zsh  # manual git clones + OMZ + zsh-users + compinit
  50-tools.zsh
os/
  linux.zsh       # Linux-specific PATH, env, OS_OMZ_PLUGINS, os_post_plugins
  mac.zsh         # macOS-specific
linux/            # platform-only dotfiles (e.g. .config/foot, .config/sway)
mac/              # platform-only dotfiles (e.g. .aerospace.toml, .config/ghostty)
install.sh
```

## How it works

`.zshrc` detects the OS via `$OSTYPE`, sources `os/$OS.zsh` first (sets system commands, `OS_OMZ_PLUGINS`, `os_post_plugins` hook), then loops through `shell/*.zsh` in numeric order. `shell/40-plugins.zsh` clones missing plugins to `${ZSH_PLUGIN_DIR:-~/.local/share/zsh/plugins}` on first run, sources OMZ libs/plugins, runs `compinit`, then calls `os_post_plugins` so OS-specific aliases (`ls`, `ll`) win over OMZ defaults.

## Adding config

- Cross-platform shell tweak → edit a file in `shell/`
- Platform-only env/alias → edit `os/linux.zsh` or `os/mac.zsh`
- Platform-only dotfile (e.g. `.config/foo/bar`) → drop it in `linux/` or `mac/`, run `./install.sh`
- Extra OMZ plugin on one OS → append to `OS_OMZ_PLUGINS` in `os/$OS.zsh`
- Override an alias OMZ clobbers → set it inside `os_post_plugins()` in `os/$OS.zsh`

## Plugin updates

Plugins are pinned to whatever was cloned on first install. To pull latest for all of them:

```sh
zsh-plugins-update
```

## Requirements

- `zsh`
- `git` (used for first-run plugin clones)
- `nvim` (optional, falls back to `vi`)
- `fzf` (used by `fcd` and the fzf plugin's keybindings)

## Known limitations

- macOS section assumes Apple Silicon Homebrew (`/opt/homebrew`). Intel Macs need `os/mac.zsh` adjusted.
