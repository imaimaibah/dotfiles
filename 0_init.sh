#!/bin/zsh

# Install tools to install brew for Linux
if [[ $(uname) == "Linux" ]];then
  sudo apt-get install build-essential procps curl zsh git file
  sudo chsh -s $(which zsh)
fi

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brew path isn't configure on Linux. Need to manually configure it.
if [[ $(uname) == "Linux" ]];then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Install tools via brew,
# Remove diff-so-fancy, lf, chezmoi, terraform
brew instal kubectl tmux git-flow-avh bat eza git-delta go nodejs glow lazygit fzf fd ripgrep jq yq neovim \
  colima helm helmfile fx go-task helm-docs gopass

# OTP tools for pass
# brew install pass-otp oath-toolkit zbar qrencode

# install stuff via cask
if [[ $(uname) == "Darwin" ]];then
  brew install --cask iterm2 slack wezterm
fi

# install nerd fonts
if [[ $(uname) == "Darwin" ]];then
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  brew install --cask font-fira-code-nerd-font
fi

# This is usuful tool to obtain values from tfstate. https://github.com/fujiwara/tfstate-lookup
# brew install fujiwara/tap/tfstate-lookup

# File Encryption tool https://github.com/FiloSottile/age/
# Secret operations. https://github.com/getsops/sops
# brew install age sops

# vals is a tool to get values from remote storage/secret services. https://github.com/helmfile/vals

