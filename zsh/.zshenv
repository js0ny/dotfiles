# ~/.zshenv
# ln -s $DOTFILES/zsh/.zshenv $ZDOTDIR/.zshenv
# This file is sourced by all zsh sessions upon startup.

# Use XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# Disable shell sessions on macOS when using default terminal
SHELL_SESSIONS_DISABLE=1 

# Zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh" 

# Also put in /etc/zsh/zshenv
# or /etc/zshenv in macOS
# sudo cp $DOTFILES/zsh/.zshenv /etc/zsh/zshenv
# sudo cp $DOTFILES/zsh/.zshenv /etc/zshenv
