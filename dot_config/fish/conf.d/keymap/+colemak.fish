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