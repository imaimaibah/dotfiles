#!/bin/zsh

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh |sh -s
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i "" 's#^ZSH_THEME=.*#ZSH_THEME="powerlevel10k/powerlevel10k"#' ~/.zshrc 
sed -i "" 's#^plugins=(\(.*\))#plugins=(\1 zsh-autosuggestions tmux kubectl vi-mode web-search)\nZSH_TMUX_AUTOSTART=false#' ~/.zshrc
