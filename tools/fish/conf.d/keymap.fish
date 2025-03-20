# $DOTFILES/tools/fish/conf.d/keymap.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/keymap.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish


# read key: `fish_key_reader`
# get current bindings: `bind`

fish_vi_key_bindings

source $DOTFILES/tools/fish/conf.d/keymap/+colemak.fish

# Emacs Hybrid
bind -M default ctrl-p up-or-search
bind -M default ctrl-n down-or-search
bind -M default ctrl-f forward-char
bind -M default ctrl-b backward-char
bind -M default ctrl-a beginning-of-line
bind -M default ctrl-e end-of-line
bind -M default ctrl-k kill-line

bind -M insert ctrl-p up-or-search
bind -M insert ctrl-n down-or-search
bind -M insert ctrl-f forward-char
bind -M insert ctrl-b backward-char
bind -M insert ctrl-a beginning-of-line
bind -M insert ctrl-e end-of-line
bind -M insert ctrl-k kill-line
bind -M insert ctrl-w backward-kill-path-component


# ctrl + backspace
bind -M insert ctrl-backspace backward-kill-path-component
# alt + backspace
bind -M insert alt-backspace backward-kill-line
# ctrl + delete
bind -M insert ctrl-delete kill-word
# alt + delete (d$)
bind -M insert alt-delete kill-line

fzf --fish | source
# C-r : fzf history search
# C-t : fzf file search
# A-c : fzf directory search
