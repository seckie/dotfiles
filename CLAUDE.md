# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository. Files prefixed with `dot_` are managed dotfiles that chezmoi installs to the home directory (e.g., `dot_zshrc` → `~/.zshrc`).

## chezmoi Commands

```bash
# Apply dotfiles to the home directory
chezmoi apply

# Preview changes before applying
chezmoi diff

# Add a new dotfile to be managed
chezmoi add ~/.somerc

# Edit a managed dotfile (opens in editor and applies on save)
chezmoi edit ~/.zshrc

# Re-add changes made directly to the home directory file
chezmoi re-add ~/.zshrc
```

## File Naming Convention

chezmoi uses filename prefixes to control behavior:
- `dot_` → replaces leading `.` (e.g., `dot_zshrc` → `~/.zshrc`)
- `private_` → sets file permissions to 0600
- `executable_` → sets file permissions to 0755
- Prefixes can be combined: `private_dot_ssh/`

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

## Shell Environment (dot_zshrc)

- Uses **mise** for runtime version management (`~/.local/bin/mise`)
- Uses **Volta** for Node.js toolchain management
- Loads private settings from `~/.zshrc.local` (not tracked in this repo)
- Includes Google Cloud SDK and Terraform completion
- Rust environment sourced from `~/.cargo/env`
- Git completion via `dot_zsh/` (git-prompt.sh, git-completion.bash, _git)

## Vim Configuration (dot_vimrc)

- Plugin manager: **dein.vim** (plugins stored at `~/dotfiles/.vim/dein/`)
- Key plugins: unite.vim, neocomplete, neosnippet, NERDTree, emmet-vim, editorconfig-vim
- Default indent: 2 spaces, expandtab
- Colorscheme: molokai

## Neovim Configuration (private_dot_config/nvim/)

- Plugin manager: **pckr.nvim** (auto-bootstraps from GitHub)
- Colorscheme: kanagawa
- Default indent: 4 spaces, expandtab
- Relative line numbers enabled
