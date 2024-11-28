# ZSH Config #
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH  # Ruby Executables
HIST_STAMPS="yyyy-mm-dd"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# plugins=(git web-search jsontools z vi-mode zsh-syntax-highlighting zsh-autosuggestions)

# Plugins (Manually Managed) #
# $ZDOTDIR/plugins

# echo "[DEBUG] Loading plugins..."
# echo $ZDOTDIR
# Load zsh-syntax-highlighting before zsh-history-substring-search
# Reference: https://github.com/zsh-users/zsh-history-substring-search?tab=readme-ov-file#usage
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Tools Related Environment Variables #

PAGER="less"
EDITOR="nvim"
VISUAL="nvim"

# Use XDG Base Directory Specification #

# ~/.azure/ -> $XDG_DATA_HOME/azure/
export AZURE_CONFIG_DIR="$XDG_DATA_HOME"/azure
# ~/.cargo/ -> $XDG_DATA_HOME/cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# ~/.cgdb/ -> $XDG_CONFIG_HOME/cgdb/
export CGDB_DIR="$XDG_CONFIG_HOME"/cgdb
# ~/.docker -> $XDG_CONFIG_HOME/docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# ~/.dotnet -> $XDG_DATA_HOME/dotnet
# Not working
# export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
# ~/.gnupg -> $XDG_CONFIG_HOME/gnupg
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
# ~/go -> $XDG_DATA_HOME/go
export GOPATH="$XDG_DATA_HOME"/go
# ~/.inputrc -> $XDG_CONFIG_HOME/readline/inputrc
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
# ~/.juliaup/ -> $XDG_DATA_HOME/julia/
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
# Check if node is installed
if command -v node > /dev/null; then
    # ~/.node_repl_history -> $XDG_STATE_HOME/node/repl_history
    export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/repl_history
    # ~/.ts_node_repl_history -> $XDG_STATE_HOME/node/ts_node_repl_history
    export TS_NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/ts_node_repl_history
    # ~/.npmrc -> $XDG_CONFIG_HOME/npm/npmrc
    export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
    # ~/.npm -> $XDG_CACHE_HOME/npm
    export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
    export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
    export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
fi
# ~/.nv -> $XDG_CACHE_HOME/nv (CUDA)
# macOS does not have Cuda; Check if CUDA is installed
if [ "$(uname)" != "Darwin" ] && [ -d "/usr/local/cuda" ]; then
    export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
fi
# ~/,parallel -> $XDG_CONFIG_HOME/parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
# ~/.python_history -> $XDG_DATA_HOME/python/history
# Works only with Python 3.13.0a3 and later
export PYTHON_HISTORY="$XDG_DATA_HOME"/python/history
# ~/.screenrc -> $XDG_CONFIG_HOME/screen/screenrc
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
# ~/.screen/ -> $XDG_RUNTIME_DIR/screen
export SCREENDIR="${XDG_RUNTIME_DIR}/screen"
# ~/.spacemacs/ -> $XDG_CONFIG_HOME/spacemacs
export SPACEMACSDIR="$XDG_CONFIG_HOME"/spacemacs
# ~/.tldrc/ -> $XDG_CACHE_HOME/tldr
export TLDR_CACHE_DIR="$XDG_CACHE_HOME"/tldr
# ~/.w3m -> $XDG_DATA_HOME/w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m
# ~/.wakatime.cfg -> $XDG_CONFIG_HOME/wakatime.cfg
# ~/.wakatime/ -> $XDG_CONFIG_HOME/wakatime/
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
# ~/.wget-hsts -> $XDG_DATA_HOME/wget-hsts
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
# ~/.z -> $XDG_DATA_HOME/z
export _Z_DATA="$XDG_DATA_HOME/z"
# ~/.zcompdump* -> $XDG_CACHE_HOME/zsh/zcompdump*
# compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
# ~/.zsh_history -> $XDG_STATE_HOME/zsh/history
export HISTFILE="$XDG_STATE_HOME"/zsh/history

# https://unix.stackexchange.com/questions/33994/
# Use `set -k` to mark leading `#` as a comment character
set -k
