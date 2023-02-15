#!/bin/sh

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
sudo apt install fzf autojump
curl -sS https://starship.rs/install.sh | sh

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sh -c "$(curl -fsLS get.chezmoi.io)"
chezmoi init --apply https://github.com/npiv/dots.git
