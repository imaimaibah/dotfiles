#!/bin/zsh

#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mkdir -p ~/.config/zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh |sh -s
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
if [[ $(uname) == "Darwin" ]];then
  sed_option='""'
fi
sed -i $sed_option 's#^ZSH_THEME=.*#ZSH_THEME="powerlevel10k/powerlevel10k"#' ~/.zshrc
if grep ZSH_TMUX_AUTOSTART ~/.zshrc &>/dev/null;then
  sed -i $sed_option 's#^plugins=(\(.*\))#plugins=(\1 zsh-autosuggestions tmux kubectl vi-mode web-search git-auto-fetch fzf-tab)\nZSH_TMUX_AUTOSTART=false#' ~/.zshrc
fi
