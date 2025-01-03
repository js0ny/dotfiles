# $DOTFILES/tools/fish/conf.d/alias.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/alias.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish

# Powershell equivalent
abbr --add ni touch
abbr --add cls clear
abbr --add ii open

# Editors #
abbr --add v nvim
abbr --add c code
alias sv="sudo vim -u ~/.dotfiles/common/vim.noxdg.vimrc"
alias sn="sudo nvim -u ~/.config/nvim/init.lua"

# Dev #
abbr --add py python3
abbr --add ipy ipython
abbr --add reload "source $__fish_config_dir/config.fish"
abbr --add pulldots "cd $DOTFILES && git pull"

# lsd - modern ls
if command -v lsd > /dev/null
    alias ls='lsd -A -I .DS_Store -I .git -I .gitkeep'
    abbr --add l 'lsd -lah'
    abbr --add ll 'lsd -l'
    abbr --add tree 'ls --tree'
else
    abbr --add l 'ls -lah'
    abbr --add ll 'ls -l'
end

# Functions #
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end
function cdls
    cd $argv[1] && ls
end
function tc
    touch $argv[1] && code $argv[1]
end
function tv
    touch $argv[1] && nvim $argv[1]
end

# Use neovide as gVim
if command -v neovide > /dev/null
    abbr --add gvi "neovide"
end

if command -v brew > /dev/null
    abbr --add brewi "brew install"
    abbr --add brewu "brew upgrade && brew update"
    abbr --add brewr "brew remove"
    abbr --add brewc "brew cleanup"
end

if command -v pacman > /dev/null
    abbr --add pac "sudo pacman"
    abbr --add paci "sudo pacman -S"
    abbr --add pacr "sudo pacman -R"
    abbr --add pacu "sudo pacman -Syu"
end
