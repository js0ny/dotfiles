# $DOTFILES/keymap.zsh
bindkey -v # Vi Keybindings

# Colemak hnei
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