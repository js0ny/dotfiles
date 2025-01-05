# $DOTFILES/tools/fish/conf.d/keymap.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/keymap.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish


fish_vi_key_bindings

# Colemak hnei
#         ^
#         e
#   < h       i >
#         n
#         v
# bind -M default 'h' backward-char
bind -M default 'n' down-or-search
bind -M default 'e' up-or-search
bind -M default 'i' forward-char

# Similar position to [i] in QWERTY
bind -M default -m insert l repaint-mode
bind -M default -m insert L beginning-of-line repaint-mode

# TODO: Add more key bindings here
