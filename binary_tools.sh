#!/usr/bin/env zsh

LOCALBIN=~/.local/bin
mkdir -p "$LOCALBIN"

# FZF Installation
URL=$(curl -fLsq https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.assets[]|select(.browser_download_url|match("linux.*arm64"))|.browser_download_url')
curl -LsSf $URL | tar zx -C "$LOCALBIN" || echo "FZF failed"

# GLOW Installation
URL=$(curl -fLsq https://api.github.com/repos/charmbracelet/glow/releases/latest | jq -r '.assets[]|select(.browser_download_url|match("Linux.*arm64.*tar.gz$"))|.browser_download_url')
curl -LsSf $URL | tar zx -C "$LOCALBIN" --wildcards "glow*/glow" || echo "GLOW failed"
mv $LOCALBIN/glow_*/glow $LOCALBIN/glow
rm -rf $LOCALBIN/glow_*
