# Praffi Dotfiles

Personal Ghostty and Neovim/LazyVim configuration.

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
- On another Mac, clone this repo and copy or symlink the folders into the install paths above.
