# AGENTS.md

Cross-platform zsh dotfiles for Linux + macOS. Symlink-based install.

## Layout

```
.zshrc            # entry, sourced as ~/.zshrc
shell/            # cross-platform, sourced in numeric order
  00-exports.zsh  # PATH, EDITOR, LOCAL_CONFIG
  10-functions.zsh
  20-options.zsh  # history
  30-aliases.zsh
  40-plugins.zsh  # manual git clones + OMZ + zsh-users + compinit
  50-tools.zsh    # mise, gcloud, etc. (guarded)
os/
  linux.zsh       # PATH, SYS_*, TERM_CONFIG, OS_OMZ_PLUGINS, os_post_plugins
  mac.zsh
linux/            # platform-only dotfiles, mirrored to $HOME by install.sh
mac/              # (may not exist)
custom.zsh        # gitignored scratch; sourced last from .zshrc
install.sh        # symlinks + .bak backup
```

## Load flow

`.zshrc` detects OS via `$OSTYPE` → sources `os/$OS.zsh` (sets system commands, `OS_OMZ_PLUGINS`, `os_post_plugins` hook) → loops `shell/*.zsh` in numeric order. `40-plugins.zsh` clones missing plugins to `${ZSH_PLUGIN_DIR:-~/.local/share/zsh/plugins}` on first run, sources OMZ libs/plugins, runs compinit, then calls `os_post_plugins` so OS aliases (ls/ll) win over OMZ defaults.

## Where to add what

- Cross-platform shell tweak → `shell/` (pick numeric prefix by load stage)
- Platform-only env/alias → `os/linux.zsh` or `os/mac.zsh`
- Platform-only dotfile (e.g. `.config/foo/bar`) → drop in `linux/` or `mac/` tree, run `./install.sh`
- New tool integration (mise, direnv, zoxide, etc.) → `shell/50-tools.zsh`, guard with `command -v`
- Transient/dev/test scratch → `custom.zsh` (repo root, gitignored, sourced last). Promote stable bits out to `shell/` or `os/`.

## Conventions

- Numeric prefix in `shell/` controls source order; new file picks gap (e.g. `25-`, `45-`) or appends.
- Guard external tools: `command -v X >/dev/null && eval "$(X init)"` or `[[ -f path ]] && . path`.
- Aliases gate on env var presence: `[[ -n "$VAR" ]] && alias x="$VAR"`. OS file sets the var, `30-aliases.zsh` consumes.
- Platform-specific OMZ plugins: append plugin name to `OS_OMZ_PLUGINS` array in `os/$OS.zsh`; consumed by `40-plugins.zsh`.
- Aliases that must override OMZ defaults: define inside `os_post_plugins()` in `os/$OS.zsh`; called at end of `40-plugins.zsh`.
- `install.sh` symlinks; pre-existing files moved to `*.bak` (existing `.bak` is overwritten).
- Repo path resolved via `${(%):-%x}:A:h` so `~/.zshrc` symlink works.
- `typeset -U PATH path` in `.zshrc` dedupes PATH; safe to prepend in multiple files.

## Requirements

- `zsh`
- `git` (for first-run plugin clones)
- `nvim` (optional, falls back to `vi`)
- `fzf` (used by `fcd` and the fzf plugin's keybindings; install via `apt install fzf` / `brew install fzf`)

## Style

- No emojis in files.
- No comments in code unless asked or non-obvious behavior needs explaining (existing comments are sparse and intentional).
- Match repo's terse README tone: fragments OK, no filler.
- Edits should be minimal; preserve existing patterns over introducing new ones.
