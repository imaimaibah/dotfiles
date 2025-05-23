#!/bin/zsh

git config --global user.name "Shin Imai"
git config --global user.email "binaryninja0101@yahoo.com"
git config --global difftool.prompt false
git config --global pull.rebase true
git config --global --add --bool push.autoSetupRemote true
git config --global core.editor nvim
git config --global core.pager bat
git config --global fetch.prune true
git config --global remote.origin.prune true
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto
git config --global delta.navigate true
git config --global delta.side-by-side true
git config --global delta.diff-so-fancy true
###############
### Aliases ###
###############
git config --global alias.alias "config --get-regexp '^alias\.'"
### Git log ###
git config --global alias.alog "log --graph --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%aN>%Creset' --abbrev-commit"
git config --global alias.lol "log --graph --decorate --pretty=oneline --abbrev-commit"
git config --global alias.lola "log --graph --decorate --pretty=oneline --abbrev-commit --all"
git config --global alias.ls "log --decorate --name-status"
git config --global alias.lsl "log --decorate --patch --stat"
git config --global alias.search "! cd -- \"\${GIT_PREFIX:-.}\"; git log --full-history --patch -S\"\$1\" --pickaxe-regex \"\${@:2}\" #"
git config --global alias.dig "! cd -- \"\${GIT_PREFIX:-.}\"; git log --full-history --patch -G\"\$1\" \"\${@:2}\" #"
### Others ###
git config --global alias.base "merge-base HEAD origin/main"
git config --global alias.track "for-each-ref --format='%(refname:short) <- %(upstream:short)' refs/heads"
git config --global alias.gone "! git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D"
git config --global alias.tagrev "rev-list -n 1"
git config --global alias.cat "show --pretty=format:'%Cred%h%Creset %C(bold blue)<%aN>%Creset %C(yellow)%d%Creset %Cgreen%ad (%cr)%Creset%n%C(yellow)%B%Creset' --abbrev-commit"
git config --global alias.tsort '! git tag | sort -V'
git config --global alias.root '!pwd'
git config --global alias.conflicts "diff --name-only --diff-filter=U --relative"
git config --global alias.delta "! cd -- \"\${GIT_PREFIX:-.}\"; git diff \"\${@}\" | delta #"
git config --global alias.ls-branch "for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' --sort=-committerdate"
