#!/bin/zsh

OS=$(uname)
ARCH=$(uname -m)

# Install tools to install brew for Linux
if [[ "$OS" == "Linux" ]];then
  sudo apt-get install build-essential procps curl zsh file docker.io
  sudo chsh -s $(which zsh)
  sudo usermod -aG docker $USER
fi

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brew path isn't configure on Linux. Need to manually configure it.
if [[ "$OS" == "Linux" ]];then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Common tools to install via brew,
# Remove diff-so-fancy, lf, chezmoi, terraform, git-flow, rust
brew instal kubectl tmux bat eza git git-delta go nodejs fd ripgrep jq neovim helm helmfile fx gopass

OPTION=""
if [[ "$OS" == "Linux") && "$ARCH" == "aarch64" ]];then
  OPTION="--build-from-source"
fi
brew install "$OPTION" fzf lazygit glow yq go-task helm-docs kind glow

# OTP tools for pass
# brew install pass-otp oath-toolkit zbar qrencode

if [[ "$OS" == "Darwin" ]];then
  # install stuff via cask
  brew colima
  brew install --cask iterm2 slack wezterm

  # install nerd fonts
  brew tap homebrew/cask-fonts
  brew install --cask font-hack-nerd-font
  brew install --cask font-fira-code-nerd-font
fi

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

# This is usuful tool to obtain values from tfstate. https://github.com/fujiwara/tfstate-lookup
# brew install fujiwara/tap/tfstate-lookup

# File Encryption tool https://github.com/FiloSottile/age/
# Secret operations. https://github.com/getsops/sops
# brew install age sops

# vals is a tool to get values from remote storage/secret services. https://github.com/helmfile/vals

