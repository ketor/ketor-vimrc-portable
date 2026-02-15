# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is **ketor-vimrc-portable**, a portable Vim configuration for C/C++, Python, PHP, and Go development. It runs on Linux and macOS with all plugins written in VimScript. Plugins are managed as git submodules via Pathogen.

## Setup Commands

```bash
bash setup.sh -i    # Fresh install
bash setup.sh -u    # Update plugins (git submodule update)
bash setup.sh -r    # Update submodules to latest remote and commit+push
bash setup.sh -b    # Create portable tarball for offline install
bash setup.sh -l    # Link vimrc only (for green install from tarball)
```

## Architecture

- `vimrc` - Main configuration: settings, keybindings, plugin configs, quickui menus
- `vimrc-completeplugin.vim` - Completion engine config (vim-lsp + asyncomplete), sourced from vimrc
- `bundle/` - All plugins as git submodules (47 plugins), loaded by vim-pathogen
- `setup.sh` - Install/update/backup script
- `tools/` - Bundled utilities (ack)
- `fonts/` - Powerline fonts

The vimrc is the single monolithic config file. It defines custom Vim commands (`:Ctags`, `:Gtags`, `:Cscope`, etc.), toggle functions for paste/mouse/number modes, cscope/gtags integration, and a full menu system via vim-quickui (opened with `<Space><Space>`).

## Key Conventions

- **Leader key**: `,`
- **Plugin manager**: Pathogen (`bundle/vim-pathogen`)
- **Completion**: vim-lsp + asyncomplete (lightweight, pure VimScript, with LSP support)
- **LSP**: vim-lsp + vim-lsp-settings (auto-detect and install language servers via `:LspInstallServer`)
- **Tag system**: Supports ctags, gtags, and cscope with automatic detection
- **F-keys**: F2-F12 are mapped to toggles/features; each also has a `<C-_>` alternative for terminals without F-keys
- **Colorscheme**: Set in `~/.vimrc` (not in this repo's vimrc); default is jellybeans

## Adding a Plugin

```bash
git submodule add https://github.com/user/repo.git bundle/plugin-name
git submodule update --init --recursive
```

Then add configuration to `vimrc`. Pathogen auto-loads anything in `bundle/`.

## Submodule Update Workflow

The commit style for submodule updates follows this pattern:
```
submodule: Update submodule YYYYMMDD.
```

## Code Style

- **Indentation**: 4 spaces (2 for HTML/JS, tabs for Makefiles)
- **Functions**: `CamelCase` (e.g., `TogglePasteMode`)
- **Variables**: `s:` prefix for script-local, `g:` for global
- **Comments**: `"` prefix, can be English or Chinese
- **Strings**: Double quotes

## Requirements

- Vim 8.1.2269+ or Neovim 0.5+
- Python 3.8+
- `TERM=xterm-256color`
- External tools: ctags, cscope/gtags (optional), ag (optional)
