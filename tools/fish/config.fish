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



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/js0ny/.local/anaconda3/bin/conda
    eval /home/js0ny/.local/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/js0ny/.local/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/js0ny/.local/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/js0ny/.local/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

