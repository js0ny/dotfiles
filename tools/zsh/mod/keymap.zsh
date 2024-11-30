# $DOTFILES/tools/zsh/mod/keymap.zsh
# Date: 2024-11-30
# Author: contact@js0ny.net
# Sourced by user's zshrc 在用户的 zshrc 中被引用


bindkey -v # Vi Keybindings

# Colemak hnei
#         ^
#         n
#   < h       i >
#         e
#         v
# bindkey -M vicmd 'h' vi-backward-char # No change
bindkey -M vicmd 'n' down-line-or-history
bindkey -M vicmd 'e' up-line-or-history
bindkey -M vicmd 'i' vi-forward-char

# Similar position to [i] in QWERTY
bindkey -M vicmd 'l' vi-insert
bindkey -M vicmd 'L' vi-insert-bol
# Ne{[k]s}t
bindkey -M vicmd 'k' vi-repeat-search
bindkey -M vicmd 'K' vi-rev-repeat-search
# [J]ump
bindkey -M vicmd 'j' vi-forward-word-end
bindkey -M vicmd 'J' vi-forward-blank-word-end
# Use N to Join
bindkey -M vicmd 'N' vi-join

# Emacs Hybrid
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history
bindkey '^R' history-incremental-search-backward
# TODO: did not test
bindkey '^K' kill-line
bindkey '^X^E' edit-command-line

# LEADER CONVENTION
# ^X defines as a prefix key in shell
# ^A defines as a prefix key in tmux
# ^B defines as a prefix key in Terminal Emulators
# SPC defines as a prefix key in nvim
