# dotfiles

My dotfiles, managed with [chezmoi](https://www.chezmoi.io/).

## Setup

```bash
chezmoi init <repo-url>
chezmoi apply
```

## What's Included

- **zsh** - mise, Volta, Google Cloud SDK, Terraform completion, Rust
- **Vim** - dein.vim, molokai theme, 2-space indent
- **Neovim** - pckr.nvim, kanagawa theme, 4-space indent
- **Git** - shell completion, global gitignore

## Usage

```bash
chezmoi apply          # Apply dotfiles
chezmoi diff           # Preview changes
chezmoi add ~/.somerc  # Track a new dotfile
chezmoi re-add ~/.zshrc  # Sync home directory changes back
```
