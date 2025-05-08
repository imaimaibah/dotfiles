#!/bin/bash

sudo apt update
sudo apt-get install build-essential procps curl zsh file
sudo chsh -s $(which zsh) "$USER"
sudo usermod -aG docker $USER

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew instal kubectl tmux bat eza git git-delta go nodejs fd ripgrep jq neovim helm helmfile fx gopass

(
  mkdir -p ~/.config
  cd ~/.config
  git clone https://github.com/imaimaibah/dotfiles.git
  cd dotfiles
  ./3_ohmyzsh.sh
  ./5_setup_tools.sh
  ./7_setup_git.sh
  git remote set-url origin git@github.com:imaimaibah/dotfiles.git
)
