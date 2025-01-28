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

# Colemak hnei
#         ^
#         e
#   < h       i >
#         n
#         v
# bind -M default 'h' backward-char
bind -M default n down-or-search
bind -M default e up-or-search
bind -M default i forward-char

# Similar position to [i] in QWERTY
bind -M default -m insert l repaint-mode
bind -M default -m insert L beginning-of-line repaint-mode

# Ne{[k]s}t -> fish doesnt have this feature

# [J]ump
bind -M default j forward-word
bind -M default J forward-bigword

# Use N to Join
bind -M default N end-of-line delete-char

# Emacs Hybrid
bind -M default \cp up-or-search
bind -M default \cn down-or-search
bind -M default \cf forward-char
bind -M default \cb backward-char
bind -M default \ca beginning-of-line
bind -M default \ce end-of-line
bind -M default \ck kill-line

bind -M insert \cp up-or-search
bind -M insert \cn down-or-search
bind -M insert \cf forward-char
bind -M insert \cb backward-char
bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line
bind -M insert \ck kill-line
bind -M insert \cw backward-kill-path-component


# ctrl + backspace
bind -M insert \b backward-kill-path-component
# alt + backspace
bind -M insert \e\x7F backward-kill-line
# ctrl + delete
bind -M insert \e\[3\;5~ kill-word
# alt + delete (d$)
bind -M insert \e\[3\;3~ kill-line

fzf --fish | source
# C-r : fzf history search
# C-t : fzf file search
# A-c : fzf directory search
