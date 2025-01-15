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
    set fish_greeting
    switch (uname)
    case "Darwin"
        # macOS Specific
        abbr --add clip pbcopy
        abbr --add paste pbpaste
    case "Linux"
        # Linux Specific
    case '*'
        # Default / Fallback case
    end
end
