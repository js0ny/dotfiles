# ZSH Config #
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
HIST_STAMPS="yyyy-mm-dd"
# plugins=(git web-search jsontools z vi-mode zsh-syntax-highlighting zsh-autosuggestions)

# Plugins (Manually Managed) #
# $ZDOTDIR/plugins

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Tools Related Environment Variables #

PAGER="less"
EDITOR="nvim"
VISUAL="nvim"

# Use XDG Base Directory Specification # 

# ~/.dotnet -> $XDG_DATA_HOME/dotnet
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
# ~/.gnupg -> $XDG_CONFIG_HOME/gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# ~/go -> $XDG_DATA_HOME/go
export GOPATH="$XDG_DATA_HOME"/go
# ~/.node_repl_history -> $XDG_STATE_HOME/node/repl_history
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/repl_history
# ~/.npmrc -> $XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# ~/.python_history -> $XDG_DATA_HOME/python/history 
# Works only with Python 3.13.0a3 and later
export PYTHON_HISTORY="$XDG_DATA_HOME"/python/history
# ~/.tldrc/ -> $XDG_CACHE_HOME/tldr
export TLDR_CACHE_DIR="$XDG_CACHE_HOME"/tldr
# ~/.w3m -> $XDG_DATA_HOME/w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m
# ~/.wakatime.cfg -> $XDG_CONFIG_HOME/wakatime.cfg
# ~/.wakatime/ -> $XDG_CONFIG_HOME/wakatime/
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
# ~/.wget-hsts -> $XDG_DATA_HOME/wget-hsts
alias wget='wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
# ~/.z -> $XDG_DATA_HOME/z
export _Z_DATA="$XDG_DATA_HOME/z"
# ~/.zcompdump* -> $XDG_CACHE_HOME/zsh/zcompdump*
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# ~/.zsh_history -> $XDG_STATE_HOME/zsh/history
export HISTFILE="$XDG_STATE_HOME"/zsh/history