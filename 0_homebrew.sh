#!/bin/zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools via brew
# Not sure if fzf is needed. I might remove fzf from neovim, too.
# Remove diff-so-fancy
brew instal kubectl tmux git-flow-avh bat eza git-delta go nodejs glow lazygit fzf fd ripgrep jq yq neovim colima helm helmfile terraform

# install stuff via cask
brew install --cask iterm2 slack

# This is usuful tool to obtain values from tfstate. https://github.com/fujiwara/tfstate-lookup
# brew install fujiwara/tap/tfstate-lookup

# File Encryption tool https://github.com/FiloSottile/age/
# brew install age

# Secret operations. https://github.com/getsops/sops

# vals is a tool to get values from remote storage/secret services. https://github.com/helmfile/vals

