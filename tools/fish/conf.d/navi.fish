# $DOTFILES/tools/fish/conf.d/navi.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/navi.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish


alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

abbr --add \- 'cd -'

if command -v zoxide > /dev/null
    zoxide init fish | source
end
