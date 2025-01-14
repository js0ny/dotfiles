# $DOTFILES/tools/fish/conf.d/0init.fish
# Date: 2024-12-19
# Author: js0ny
# By dictionary order, this file is sourced first in fish shell
# Define user-specific environment variables for fish

# Location:
# ~/.config/fish/conf.d/0init.fish (default location)
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish


set -gx DOTFILES $HOME/.dotfiles
# XDG Base Directory Specification
set -gx XDG_CONFIG_HOME (set -q XDG_CONFIG_HOME; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)
set -gx XDG_DATA_HOME (set -q XDG_DATA_HOME; and echo $XDG_DATA_HOME; or echo $HOME/.local/share)
set -gx XDG_STATE_HOME (set -q XDG_STATE_HOME; and echo $XDG_STATE_HOME; or echo $HOME/.local/state)
set -gx XDG_CACHE_HOME (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)
set -gx XDG_RUNTIME_DIR /run/user/(id -u)

set -gx PAGER "less -R"
set -gx EDITOR nvim
set -gx VISUAL nvim

# Minimal PATH for early commands
set -gx PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin ~/.local/bin $PATH

if test -d /opt/homebrew/bin # macOS
    set -gx PATH /opt/homebrew/bin $PATH
else if test -d /home/linuxbrew/.linuxbrew/bin # Linux
    set -gx PATH /home/linuxbrew/.linuxbrew/bin $PATH
end

if command -v brew > /dev/null
    set -gx HOMEBREW_NO_ENV_HINTS
end

# Azure CLI
if command -v az > /dev/null
    set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure
end
# Bun JS
if command -v bun > /dev/null
    set -gx BUN_INSTALL "$XDG_DATA_HOME/bun"
    set -gx PATH $BUN_INSTALL/bin $PATH
end
# Rust Cargo
if command -v cargo > /dev/null
    set -gx CARGO_HOME $XDG_DATA_HOME/cargo
    set -gx PATH $CARGO_HOME/bin $PATH
end
# CGDB
if command -v cgdb > /dev/null
    set -gx CGDB_DIR $XDG_CONFIG_HOME/cgdb
end
# .NET
if command -v dotnet > /dev/null
    set -gx DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
    set -gx PATH $DOTNET_CLI_HOME/.dotnet/tools $PATH
end
# Docker
if command -v docker > /dev/null
    set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
end
# GnuPG
if command -v gpg > /dev/null
    set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
end
# Go
if command -v go > /dev/null
    set -gx GOPATH $XDG_DATA_HOME/go
    set PATH $GOPATH/bin $PATH
end
# Julia
if command -v julia > /dev/null
    set -gx JULIA_DEPOT_PATH $XDG_DATA_HOME/julia
end
# Node.js
if command -v node > /dev/null
    set -gx NODE_REPL_HISTORY $XDG_STATE_HOME/node/repl_history
    set -gx TS_NODE_REPL_HISTORY $XDG_STATE_HOME/node/ts_repl_history
    set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
    set -gx NPM_CONFIG_INIT_MODULE $XDG_CONFIG_HOME/npm/config/npm-init.js
    set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm
    set -gx NPM_CONFIG_TMP $XDG_RUNTIME_DIR/npm
end
# Parallel
if command -v parallel > /dev/null
    set -gx PARALLEL_CONFIG $XDG_CONFIG_HOME/parallel
end
# Python
# Works only with Python 3.13.0a3 and later
if command -v python3 > /dev/null
    set -gx PYTHON_HISTORY $XDG_DATA_HOME/python/history
end
# GNU Screen
if command -v screen > /dev/null
    set -gx SCREENRC $XDG_CONFIG_HOME/screen/screenrc
    set -gx SCREENDIR $XDG_RUNTIME_DIR/screen
end
# Ruby Gem
if command -v gem > /dev/null
    for dir in $HOME/.local/share/gem/ruby/*/bin
        if test -d $dir
            set -gx PATH $dir $PATH
        end
    end
    set -gx PATH $HOME/.local/share/gem/ruby/3.3.0/bin $PATH
end
# Spacemacs
if command -v emacs > /dev/null
    set -gx SPACEMACSDIR $XDG_CONFIG_HOME/spacemacs
end
# tldr
if command -v tldr > /dev/null
    set -gx TLDR_CACHE_DIR $XDG_CACHE_HOME/tldr
end
# W3M
if command -v w3m > /dev/null
    set -gx W3M_DIR $XDG_DATA_HOME/w3m
end
# Wakatime
if command -v wakatime > /dev/null
    set -gx WAKATIME_HOME $XDG_CONFIG_HOME/wakatime
end
# Wget
if command -v wget > /dev/null
    alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
end
# z
if command -v z > /dev/null
    set -gx _Z_DATA $XDG_DATA_HOME/z
end
if command -v tldr > /dev/null
    set -gx TLDR_CACHE_DIR $XDG_CACHE_HOME/tldr
end
if status is-interactive
    if command -v ipython > /dev/null
        set IPYTHONDIR $XDG_CONFIG_HOME/ipython
    end
end

# Coursier: Scala dependency manager
if command -v coursier > /dev/null
    set -gx PATH "$PATH:$XDG_DATA_HOME/coursier/bin"
end
# pnpm
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

test -d /opt/miniconda3 && source /opt/miniconda3/etc/fish/conf.d/conda.fish
