# ~/.zshenv
# ln -s ~/.dotfiles/zsh/.zshenv ~/.zshenv
# This file is sourced by all zsh sessions upon startup.

# Use XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
