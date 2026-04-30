# AGENTS.md

Cross-platform zsh dotfiles for Linux + macOS. Symlink-based install.

## Layout

```
.zshrc            # entry, sourced as ~/.zshrc
shell/            # cross-platform, sourced in numeric order
  00-exports.zsh  # PATH, EDITOR, LOCAL_CONFIG
  10-functions.zsh
  20-options.zsh  # history, compinit
  30-aliases.zsh
  40-plugins.zsh  # zplug + OMZ + zsh-users
  50-tools.zsh    # mise, gcloud, etc. (guarded)
os/
  linux.zsh       # PATH, SYS_*, TERM_CONFIG, ZPLUG_HOME, os_extra_plugins
  mac.zsh
linux/            # platform-only dotfiles, mirrored to $HOME by install.sh
mac/              # (may not exist)
install.sh        # symlinks + .bak backup
```

## Load flow

`.zshrc` detects OS via `$OSTYPE` → sources `os/$OS.zsh` (sets `ZPLUG_HOME`, system commands, OS aliases, `os_extra_plugins` hook) → loops `shell/*.zsh` in numeric order.

## Where to add what

- Cross-platform shell tweak → `shell/` (pick numeric prefix by load stage)
- Platform-only env/alias → `os/linux.zsh` or `os/mac.zsh`
- Platform-only dotfile (e.g. `.config/foo/bar`) → drop in `linux/` or `mac/` tree, run `./install.sh`
- New tool integration (mise, direnv, zoxide, etc.) → `shell/50-tools.zsh`, guard with `command -v`

## Conventions

- Numeric prefix in `shell/` controls source order; new file picks gap (e.g. `25-`, `45-`) or appends.
- Guard external tools: `command -v X >/dev/null && eval "$(X init)"` or `[[ -f path ]] && . path`.
- Aliases gate on env var presence: `[[ -n "$VAR" ]] && alias x="$VAR"`. OS file sets the var, `30-aliases.zsh` consumes.
- Platform-specific zplug entries go in `os_extra_plugins` function in `os/$OS.zsh`; called from `40-plugins.zsh`.
- `install.sh` symlinks; pre-existing files moved to `*.bak` (existing `.bak` is overwritten).
- Repo path resolved via `${(%):-%x}:A:h` so `~/.zshrc` symlink works.
- `typeset -U PATH path` in `.zshrc` dedupes PATH; safe to prepend in multiple files.

## Requirements

- `zsh`
- [`zplug`](https://github.com/zplug/zplug) — Linux: `/usr/share/zplug`; macOS: `brew install zplug`. Missing zplug → `40-plugins.zsh` skips with warning.
- `nvim` (optional, falls back to `vi`)
- `fzf` (used by `fcd`)

## Style

- No emojis in files.
- No comments in code unless asked or non-obvious behavior needs explaining (existing comments are sparse and intentional).
- Match repo's terse README tone: fragments OK, no filler.
- Edits should be minimal; preserve existing patterns over introducing new ones.
