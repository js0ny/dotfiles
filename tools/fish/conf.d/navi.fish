# $DOTFILES/tools/fish/conf.d/navi.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/navi.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish



if command -v zoxide > /dev/null
    zoxide init fish | source
    alias ..="z .."
    alias ...="z ../.."
    alias ....="z ../../.."
    alias .....="z ../../../.."
    alias ......="z ../../../../.."

    abbr --add \- 'z -'


    function zls
        z $argv[1] && ls
    end
else
    alias ..="cd .."
    alias ...="cd ../.."
    alias ....="cd ../../.."
    alias .....="cd ../../../.."
    alias ......="cd ../../../../.."

    abbr --add \- 'cd -'
end
