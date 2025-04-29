#!/bin/zsh

BASEPATH=${0%%$(basename $0)}
if [[ "x${BASEPATH}" == x"" ]];then
  BASEPATH=./
fi

### TMUX ###
### Install tmux stuff ##
## tmux bar
(
  cd ~
  git clone https://github.com/gpakosz/.tmux.git
  ln -fs .tmux/.tmux.conf .tmux.conf
  cat .tmux/.tmux.conf.local > ./.tmux.conf.local
)

## Gitmux
LOCALBIN=~/.local/bin
mkdir -p $LOCALBIN
URL=$(curl -fLsq https://api.github.com/repos/arl/gitmux/releases/latest |
  awk '$1~/download_url/ && $2~/macOS_arm64/ {print $2}' | tr -d '"')
curl -Lsqf $URL | tar zx -C $LOCALBIN/ && chmod +x $LOCALBIN/gitmux || echo "Downloadin gitmux failed"

## kube-tmux
# git clone https://github.com/imaimaibah/kube-tmux.git ~/.tmux/kube-tmux

### BAT ###
if [ ! -e ~/.config/bat ];then
  ln -sf $(pwd)/bat ~/.config/bat
fi
bat cache --build

### GLOW ###
if [ ! -e ~/.config/glow ];then
  ln -sf $(pwd)/glow ~/.config/glow
fi

### LF ###
if [ ! -e ~/.config/lf ];then
  ln -fs $(pwd)/lf ~/.config/lf
fi

### Lazygit ###
if [ ! -e ~/.config/lazygit ];then
  ln -fs $(pwd)/lazygit ~/.config/lazygit
fi

### fzf-git ###
if [ ! -e ~/.local/bin/fzf-git.sh ];then
  curl -sSL -q https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh -o ~/.local/bin/fzf-git.sh
fi

### fzf-tab ###
if [ ! -e ~/.local/bin/fzf-zsh-completion.sh ];then
  curl -sSL -q https://raw.githubusercontent.com/lincheney/fzf-tab-completion/master/zsh/fzf-zsh-completion.sh -o ~/.local/bin/fzf-zsh-completion.sh
fi

### HELM PLUGINS ###
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets
helm plugin install https://github.com/aslafy-z/helm-git --version 1.3.0

# Install Krew and plugins
if [ ! -e ~/.krew ];then
(
  cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  ~/.krew/bin/kubectl-krew install ctx ns stern
)
fi

### Create symlinks for dotfiles
for file in $(ls ${BASEPATH}*_custom); do
  dotfile=${file##*/}
  ln -fs $(pwd)/${dotfile} ~/.${dotfile}
done

if ! grep -E "source-file.*\.tmux\.conf_custom" ~/.tmux.conf.local &>/dev/null; then
  echo "source-file ~/.tmux.conf_custom" >>~/.tmux.conf.local
fi

if ! grep -E "source.*\.zshrc_custom" ~/.zshrc &>/dev/null; then
  echo "source ~/.zshrc_custom" >>~/.zshrc
  . ~/.zshrc
fi
