# Repository Guidelines

## Project Structure & Module Organization

This repository is a [chezmoi](https://www.chezmoi.io/) source directory, not an application with a build tree. Source entries map to files in the home directory:

- `dot_zshrc`, `dot_vimrc`, and `dot_zsh/` manage shell and Vim files.
- `private_dot_config/` contains private configuration for Neovim, Ghostty, and chezmoi.
- `dot_claude/` and `dot_codex/` contain user-level AI tool configuration and templates.
- `dot_local/bin/` contains executable helper scripts.
- `README.md` and `CLAUDE.md` document this repository; there is no dedicated test directory.

Use chezmoi prefixes deliberately: `dot_` creates a leading dot, `private_` sets restrictive permissions, and `executable_` marks a file executable. Prefixes may be combined, as in `private_dot_config/`.

## Build, Test, and Development Commands

There is no build step or automated test suite. Use these commands while developing:

```bash
chezmoi diff                 # Preview rendered changes
chezmoi apply                # Apply changes to the home directory
chezmoi managed               # Confirm target files managed by chezmoi
chezmoi execute-template < file.tmpl  # Render/check a template
```

For scripts, run the appropriate syntax check (`sh -n`, `bash -n`, or `python3 -m py_compile`) before applying changes. Review `chezmoi diff` before any apply.

## Coding Style & Naming Conventions

Preserve the existing language style: shell scripts use clear POSIX/Bash conventions, Neovim Lua uses four-space indentation, and Vimscript uses two spaces. Keep chezmoi templates explicit and avoid embedding machine-specific secrets; use template data or local files for conditional/private values. Match existing kebab-case names for executable scripts and descriptive lowercase configuration paths.

## Testing Guidelines

Since no framework or coverage threshold is configured, validate rendered output with `chezmoi diff`, syntax-check changed scripts, and inspect the resulting target path after applying. Test conditional templates for both relevant branches when practical.

## Commit & Pull Request Guidelines

Use concise, imperative Conventional Commit-style subjects, commonly scoped by tool, for example `fix(codex): ...`, `chore(chezmoi): ...`, or `feat(statusline): ...`. Pull requests should explain the target behavior, list validation commands and affected target paths, and call out template or permission changes. Include screenshots only when a visual terminal/configuration change benefits from them.
