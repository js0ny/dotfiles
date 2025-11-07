
### completion
### =================

# use tab to select
zstyle ':completion:*' menu select

# substring matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# use cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

# Colours in completion
zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

