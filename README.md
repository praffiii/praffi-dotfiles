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

## Notes

- This repo uses copy-based install steps, not Stow or symlinks.
- Neovim plugin/cache/state folders are generated locally and are not part of this repo.
