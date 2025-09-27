#!/bin/sh

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

test -d "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions" || git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-autosuggestions"
test -d "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting" || git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-syntax-highlighting"
test -d "$XDG_CONFIG_HOME/zsh/plugins/zsh-history-substring-search" || git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-history-substring-search"
test -d "$XDG_CONFIG_HOME/zsh/plugins/zsh-completions" || git clone --depth 1 https://github.com/zsh-users/zsh-completions.git "$XDG_CONFIG_HOME/zsh/plugins/zsh-completions"

