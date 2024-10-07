#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools via brew
# Remove diff-so-fancy
brew instal kubectl tmux git-flow-avh bat eza git-delta go nodejs glow lazygit fzf fd ripgrep jq yq neovim \
  colima helm helmfile terraform chezmoi fx go-task lf

# install stuff via cask
brew install --cask iterm2 slack wezterm

# install nerd fonts
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code-nerd-font

# This is usuful tool to obtain values from tfstate. https://github.com/fujiwara/tfstate-lookup
# brew install fujiwara/tap/tfstate-lookup

# File Encryption tool https://github.com/FiloSottile/age/
# Secret operations. https://github.com/getsops/sops
# brew install age sops

# vals is a tool to get values from remote storage/secret services. https://github.com/helmfile/vals

