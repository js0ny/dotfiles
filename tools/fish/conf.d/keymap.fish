fish_vi_key_bindings

# Colemak hnei
#         ^
#         n
#   < h       i >
#         e
#         v
# bind -M default 'h' backward-char
bind -M default 'n' down-or-search
bind -M default 'e' up-or-search
bind -M default 'i' forward-char

# Similar position to [i] in QWERTY
bind -M default -m insert l repaint-mode
bind -M default -m insert L beginning-of-line repaint-mode
