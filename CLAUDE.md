# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository. Files prefixed with `dot_` are managed dotfiles that chezmoi installs to the home directory (e.g., `dot_zshrc` → `~/.zshrc`).

## Two Different CLAUDE.md Files — Don't Mix Them Up

This repository is a chezmoi source directory, so a file at its root is a *candidate for deployment*, not just documentation. There are two distinct CLAUDE.md files with separate jobs:

| File | Role |
|---|---|
| `CLAUDE.md` (this file) | Context for Claude Code **running in this repository**. Listed in `.chezmoiignore`, so it is never deployed. |
| `dot_claude/CLAUDE.md` | User-level global instructions, deployed to `~/.claude/CLAUDE.md` and applied to **every** project on the machine. |

Rules that follow from this:

- Repository-specific knowledge (chezmoi mechanics, this file layout) goes here — never in `dot_claude/CLAUDE.md`, or it leaks into unrelated projects.
- Machine-wide preferences go in `dot_claude/CLAUDE.md` — never here, since this file is only read inside this repository.
- When adding any new file **without** a `dot_`/`private_`/`executable_` prefix that is repository metadata rather than a dotfile, add it to `.chezmoiignore` too. Otherwise `chezmoi apply` copies it into `~` under the same name.

Dot-prefixed source entries (`.claude/`, `.chezmoi.toml.tmpl`, `.commit-message.tmpl`, `.gitignore`) are ignored by chezmoi automatically and need no `.chezmoiignore` entry.

## chezmoi Commands

```bash
chezmoi apply              # Apply dotfiles to home directory
chezmoi diff               # Preview changes before applying
chezmoi add ~/.somerc      # Add a new dotfile to be managed
chezmoi edit ~/.zshrc      # Edit a managed dotfile (opens in editor, applies on save)
chezmoi re-add ~/.zshrc    # Sync changes made directly to installed file back to source
```

## File Naming Convention

chezmoi uses filename prefixes to control behavior:
- `dot_` → replaces leading `.` (e.g., `dot_zshrc` → `~/.zshrc`)
- `private_` → sets file permissions to 0600
- `executable_` → sets file permissions to 0755
- Prefixes can be combined: `private_dot_config/`

## Git Auto-Commit / Auto-Push

Configured in `.chezmoi.toml.tmpl`: `git.autoCommit = true` and `git.autoPush = true`. Every `chezmoi add` or `chezmoi re-add` automatically commits and pushes.

The commit message template (`.commit-message.tmpl`) uses `.chezmoi.status` to list changed target paths. Available template data:
- `.chezmoi.status.Ordinary` — added/modified/deleted files (each has `.X`, `.Y`, `.Path`)
- `.chezmoi.status.RenamedOrCopied` — renamed/copied files (each has `.Path`, `.OrigPath`)
- `.chezmoi.status.Untracked` — untracked files (each has `.Path`)
- `targetRelPath` — template function to convert source path (e.g., `dot_zshrc`) to target path (e.g., `.zshrc`)

## Managed Files

| Repository path | Installed as |
|---|---|
| `dot_zshrc` | `~/.zshrc` |
| `dot_bash_profile` | `~/.bash_profile` |
| `dot_vimrc` | `~/.vimrc` |
| `dot_gvimrc` | `~/.gvimrc` |
| `dot_gitignore` | `~/.gitignore` |
| `dot_zsh/` | `~/.zsh/` (git completion scripts) |
| `dot_claude/` | `~/.claude/` (`CLAUDE.md`, `settings.json`, `statusline-command.sh`) |
| `dot_local/bin/executable_update-ghostty-fontsize` | `~/.local/bin/update-ghostty-fontsize` |
| `private_dot_config/nvim/` | `~/.config/nvim/` |
| `private_dot_config/ghostty/config` | `~/.config/ghostty/config` |
| `private_dot_config/chezmoi/chezmoi.toml` | `~/.config/chezmoi/chezmoi.toml` |

Verify with `chezmoi managed` after changing anything here.

### Files that are NOT deployed

| Path | Why |
|---|---|
| `CLAUDE.md` | Repository context; excluded via `.chezmoiignore` |
| `README.md` | Repository documentation; excluded via `.chezmoiignore` |
| `nvim.log` | Stray log file; excluded via `.chezmoiignore` and `.gitignore` |
| `.claude/` | Project-level Claude Code settings; dot-prefixed, auto-ignored |
| `.chezmoi.toml.tmpl`, `.commit-message.tmpl` | chezmoi's own config; dot-prefixed, auto-ignored |

### `.gitignore` vs `dot_gitignore`

Easy to confuse, and they are unrelated:

- `.gitignore` — git config for *this repository* (currently just `nvim.log`). Not deployed.
- `dot_gitignore` — deployed to `~/.gitignore` as the user's global git ignore file.

## Configuration Templates

`.chezmoi.toml.tmpl` prompts for user data on `chezmoi init`:
- `name`, `email` — user identity
- `is_work` — boolean flag for work vs personal machine

These values are available as `.name`, `.email`, `.is_work` in any chezmoi template file.

## Shell Environment (dot_zshrc)

- Uses **mise** for runtime version management (`~/.local/bin/mise`)
- Uses **Volta** for Node.js toolchain management
- Loads private settings from `~/.zshrc.local` (not tracked in this repo)
- Includes Google Cloud SDK and Terraform completion
- Rust environment sourced from `~/.cargo/env`
- Git completion via `dot_zsh/` (git-prompt.sh, git-completion.bash, _git)

## Neovim Configuration (private_dot_config/nvim/)

- Plugin manager: **pckr.nvim** (auto-bootstraps from GitHub)
- Colorscheme: kanagawa
- Default indent: 4 spaces, expandtab
- Relative line numbers enabled
- System clipboard integration (`unnamedplus`)

## Vim Configuration (dot_vimrc)

- Plugin manager: **dein.vim** (plugins stored at `~/dotfiles/.vim/dein/`)
- Default indent: 2 spaces, expandtab
- Colorscheme: molokai
