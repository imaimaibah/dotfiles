#!/bin/zsh

if [ -d "$HOME/.config/nvim" ]; then
  rm -rf ~/.config/nvim
fi

if [ -d "$HOME/.local/state/nvim" ]; then
  rm -rf ~/.local/state/nvim
fi

if [ -d "$HOME/.local/share/nvim" ]; then
  rm -rf ~/.local/share/nvim
fi

if [ -d "$HOME/.cache/nvim" ]; then
  rm -rf ~/.cache/nvim
fi

if [ ! -d "$HOME/.config/nvim.lazyvim" ]; then
  mkdir ~/.config/nvim.lazyvim
  cd ~/.config/nvim.lazyvim
  git clone https://github.com/imaimaibah/lazyvim-starter.git .
  ln -sf ~/.config/nvim.lazyvim ~/.config/nvim
  ln -sf ~/.local/share/nvim.lazyvim ~/.local/share/nvim
  ln -sf ~/.local/state/nvim.lazyvim ~/.local/state/nvim
  ln -sf ~/.cache/nvim.lazyvim ~/.cache/nvim
fi
