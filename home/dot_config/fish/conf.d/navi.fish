# $DOTFILES/tools/fish/conf.d/navi.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/navi.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish

set __CD_CMD "cd"


if command -v zoxide > /dev/null
    set __CD_CMD "z"
    zoxide init fish | source
end


alias ..="$__CD_CMD .."
alias ...="$__CD_CMD ../.."
alias ....="$__CD_CMD ../../.."
alias .....="$__CD_CMD ../../../.."
alias ......="$__CD_CMD ../../../../.."

abbr --add \- "$__CD_CMD -"


function zls
    $__CD_CMD $argv[1] && ls
end

alias cdls=zls

function __source_quick_jump
    set dir (fd --type d --max-depth 1 . ~/Source/ | fzf --preview 'lsd --color always --icon always {}')
    if test -n "$dir"
        cd "$dir"
    end
end
# Quick Jump Directories
test -d $DOTFILES && abbr --add dot "$__CD_CMD $DOTFILES"
test -d $HOME/Downloads && abbr --add down "$__CD_CMD $HOME/Downloads"
test -d $HOME/.config && abbr --add conf "$__CD_CMD $HOME/.config"
test -d $HOME/Obsidian && abbr --add ob "$__CD_CMD $HOME/Obsidian"
test -d $HOME/Source && alias src="__source_quick_jump"
test -d $HOME/Source/Scripts && alias scr="fd --type f --hidden --exclude .git --exclude '.*' . ~/Source/Scripts/ | fzf --preview 'bat --color=always --style=numbers {}' | xargs -r nvim"
test -d $HOME/OrgFiles && abbr --add org "$__CD_CMD $HOME/OrgFiles"
