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
  ln -s -f .tmux/.tmux.conf .tmux.conf
  cp .tmux/.tmux.conf.local .
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
ln -sf $(pwd)/bat ~/.config/bat

### LF ###
ln -fs $(pwd)/lf ~/.config/lf

### HELM PLUGINS ###
helm plugin install https://github.com/databus23/helm-diff
helm plugin install https://github.com/jkroepke/helm-secrets

# Install Krew and plugins
(
  set -x
  cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  ~/.krew/bin/kubectl-krew install ctx ns stern
)

### Create symlinks for dotfiles
for file in $(ls ${BASEPATH}*_custom); do
  dotfile=${file##*/}
  ln -fs $(pwd)/${dotfile} ~/.${dotfile}
done

if ! grep -E "source-file.*\.tmux\.conf_custom" ~/.tmux.conf.local &>/dev/null; then
  echo "source-file ~/.tmux.conf_custom" >>~/.tmux.conf.local
fi

if ! grep -E "source.*\.zshrc_custom" ~/.zshrc; then
  echo "source ~/.zshrc_custom" >>~/.zshrc
  . ~/.zshrc
fi
