
if command -v starship > /dev/null
    set -gx STARSHIP_CONFIG $DOTFILES/tools/starship/starship_fish.toml
    starship init fish | source
end
