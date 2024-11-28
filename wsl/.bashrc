# Append to original bashrc for minimal setup
# echo $DOTFILES/wsl/.bashrc >> ~/.bashrc
bind 'set show-mode-in-prompt on'
set -o vi

bind -m vi-command '"n": next-history'
bind -m vi-command '"e": previous-history'
bind -m vi-command '"l": vi-insertion-mode'
bind -m vi-command '"L": vi-insert-beg'
bind -m vi-command '"i": forward-char'

# bind -m vi-insert '"\C-r": reverse-search-history"'
# bind -m vi-insert '"\C-l": clear-screen'

bind -m vi-command '"j": vi-end-word'
bind -m vi-command '"J": vi-end-word'
