# dotfiles

Personal zsh + config files. Cross-platform (Linux, macOS).

## Install

```sh
./install.sh
```

Symlinks `~/.zshrc` to `.zshrc` and any platform-specific files from `linux/` or `mac/` into `$HOME`. Existing files are backed up to `*.bak`.

## Layout

```
.zshrc            # entry point, sourced as ~/.zshrc
shell/            # cross-platform config (sourced in order by filename)
  00-exports.zsh
  10-functions.zsh
  20-options.zsh
  30-aliases.zsh
  40-plugins.zsh
os/
  linux.zsh       # Linux-specific PATH, env, aliases, zplug plugins
  mac.zsh        # macOS-specific
linux/            # platform-only dotfiles (e.g. .config/foot, .config/sway)
mac/
install.sh
```

## How it works

`.zshrc` detects the OS via `$OSTYPE`, sources `os/$OS.zsh` first (sets `ZPLUG_HOME`, system commands, OS aliases), then loops through `shell/*.zsh` in numeric order. OS files can define an `os_extra_plugins` function to add platform-specific zplug plugins.

## Adding config

- Cross-platform shell tweak → edit a file in `shell/`
- Platform-only env/alias → edit `os/linux.zsh` or `os/mac.zsh`
- Platform-only dotfile (e.g. `.config/foo/bar`) → drop it in `linux/` or `mac/`, run `./install.sh`

## Requirements

- `zsh`
- [`zplug`](https://github.com/zplug/zplug) (Linux: `/usr/share/zplug`; macOS: `brew install zplug`)
- `nvim` (optional, falls back to `vi`)
- `fzf` (used by `fcd`)
