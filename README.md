# Praffi Dotfiles

Personal Ghostty and Neovim/LazyVim configuration.

## Install On A New Mac

Clone the repo:

```sh
git clone https://github.com/praffiii/praffi-dotfiles.git ~/praffi-dotfiles
cd ~/praffi-dotfiles
```

### Install Ghostty Config

Back up your existing Ghostty config first:

```sh
mkdir -p ~/ghostty-backup
cp -R ~/Library/Application\ Support/com.mitchellh.ghostty ~/ghostty-backup/com.mitchellh.ghostty.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
```

Install this repo's Ghostty config:

```sh
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
mkdir -p ~/.config/ghostty

cp ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config
cp -R ghostty/shaders ~/.config/ghostty/shaders
```

Restart Ghostty after copying the config.

### Install Neovim Config

Back up your existing Neovim config and generated state:

```sh
mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
mv ~/.local/share/nvim ~/.local/share/nvim.bak.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
mv ~/.local/state/nvim ~/.local/state/nvim.bak.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
mv ~/.cache/nvim ~/.cache/nvim.bak.$(date +%Y%m%d-%H%M%S) 2>/dev/null || true
```

Install this repo's Neovim config:

```sh
mkdir -p ~/.config
cp -R nvim ~/.config/nvim
```

Open Neovim and let Lazy install plugins:

```sh
nvim
```

Inside Neovim, you can also run:

```vim
:Lazy sync
```

## Requirements

Install the basics with Homebrew:

```sh
brew install neovim git ripgrep fd fzf lazygit tree-sitter
```

Recommended:

```sh
brew install --cask ghostty
```

Use a Nerd Font in Ghostty. This config currently expects:

```text
JetBrainsMono Nerd Font
```

## Structure

```text
ghostty/
  config
  shaders/
    cursor.glsl

nvim/
  init.lua
  lazy-lock.json
  lazyvim.json
  lua/
    config/
    plugins/
  stylua.toml
```

## Install Paths

Ghostty config:

```text
~/Library/Application Support/com.mitchellh.ghostty/config
```

Ghostty shaders:

```text
~/.config/ghostty/shaders/
```

Neovim config:

```text
~/.config/nvim/
```

## Notes

- Do not commit Neovim generated folders like `~/.local/share/nvim`, `~/.local/state/nvim`, or `~/.cache/nvim`.
- Keep app caches and local state outside this repo.
- This repo uses copy-based install steps, not Stow or symlinks.
