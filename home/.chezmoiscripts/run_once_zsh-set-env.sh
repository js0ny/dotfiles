#!/bin/sh

XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

if [ -f /etc/zshenv ]; then
    sudo cp "$CHEZMOI_SOURCE_DIR/dot_config/zsh/global.zshenv" /etc/zshenv
fi

if [ -f /etc/zsh/zshenv ]; then
    sudo cp "$CHEZMOI_SOURCE_DIR/dot_config/zsh/global.zshenv" /etc/zsh/zshenv
fi

mkdir -p $XDG_STATE_HOME/zsh
