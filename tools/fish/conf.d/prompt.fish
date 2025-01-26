# $DOTFILES/tools/fish/conf.d/prompt.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/prompt.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish

if command -v starship > /dev/null
    #set -gx STARSHIP_CONFIG "~/.dotfiles/tools/starship/starship_fish.toml"
    starship init fish | source
end
