# $DOTFILES/tools/fish/config.fish
# Date: 2024-12-15
# Author: js0ny
# Define interactive shell configurations for fish

# Location:
# ~/.config/fish/config.fish (default location)
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    switch (uname)
    case "Darwin"
        # macOS Specific
        abbr --add clip pbcopy
        abbr --add paste pbpaste
        # Use GNU Coreutils
        alias cp=gcp
        alias ln=gln
        alias mkdir=gmkdir
        alias mv=gmv
        alias rm=grm
        alias rmdir=grmdir
        alias touch=gtouch

    case "Linux"
        # Linux Specific
    case '*'
        # Default / Fallback case
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
