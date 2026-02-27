# dotfiles

Install: clone this repo to `~/code/dotfiles`, then run `stow -v -t ~ bash nvim alacritty zellij tmux wezterm claude userbin` from repo root.
(Optional) set bash as default shell with `chsh -s /bin/bash` (or your brew bash path).

## Required tools

- `stow` — symlink package directories into your home folder.
- `bash` — primary shell config in this repo.
- `rg` (ripgrep) — fast recursive grep over the filesystem.
- `fd` — fast file/directory finder used by shell helpers.
- `fzf` — fuzzy finder used in shell workflows.
- `eza` — modern `ls` replacement.
- `bat` — file preview with syntax highlighting.
- `zoxide` — smarter directory jumping.
- `atuin` — shell history/search integration.
- `yazi` — terminal file manager (`y` helper function).
- `nvim` — editor used throughout config/scripts.
- `uv` — Python tool/runtime launcher for scripts.
- `starship` — prompt/statusline for bash.
