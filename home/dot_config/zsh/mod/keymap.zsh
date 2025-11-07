# $DOTFILES/tools/zsh/mod/keymap.zsh
# Date: 2024-11-30
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# read key: `read`
# get current bindings: `bindkey`

# bindkey -v # Vi Keybindings

bindkey '^H' backward-kill-word   # Ctrl-Backspace
bindkey '^[^?' backward-kill-line # Alt-Backspace

bindkey '^[[1;5D' backward-word  # Ctrl-Left
bindkey '^[[1;5C' forward-word   # Ctrl-Right

bindkey '^[[1;3D' beginning-of-line # Alt-Left
bindkey '^[[1;3C' end-of-line # Alt-Right


bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line       # End


bindkey '^[[3~' delete-char # Delete
bindkey '^[[3;5~' kill-word # Ctrl-Delete
bindkey '^[[3;3~' kill-line # Alt-Delete
