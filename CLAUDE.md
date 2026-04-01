# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository. Files prefixed with `dot_` are managed dotfiles that chezmoi installs to the home directory (e.g., `dot_zshrc` → `~/.zshrc`).

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
| `private_dot_config/nvim/` | `~/.config/nvim/` |

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
