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
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# moonbit
fish_add_path "$HOME/.moon/bin"
