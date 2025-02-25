# $DOTFILES/tools/fish/conf.d/alias.fish
# Date: 2024-12-22
# Author: js0ny

# Location:
# ~/.config/fish/conf.d/alias.fish
# Linking: Link the whole directory for submodules
# ln -sf $DOTFILES/tools/fish ~/.config/fish


switch (uname)
case "Darwin"
    # macOS Specific
    #abbr --add clip pbcopy
    #abbr --add paste pbpaste
    alias clip="pbcopy"
    alias paste="pbpaste"
    # Use GNU Coreutils
    alias cp=gcp
    alias ln=gln
    alias mkdir=gmkdir
    alias mv=gmv
    alias rm=grm
    alias rmdir=grmdir
    alias touch=gtouch
    alias clip=pbcopy
    alias paste=pbpaste
    abbr --add reboot "sudo reboot"
case "Linux"
    # Linux Specific
    #switch($XDG_SESSION_TYPE)
    #case "wayland"
        # Wayland Specific
        alias clip="wl-copy"
        alias paste="wl-paste"
    #case "x11"
    #    # X11 Specific
    #    alias clip="xclip -selection clipboard"
    #    alias paste="xclip -selection clipboard -o"
case '*'
    # Default / Fallback case
    alias clip="xclip -selection clipboard"
    alias paste="xclip -selection clipboard -o"
end

# Powershell equivalent
abbr --add ni touch
abbr --add cls clear
abbr --add ii open

# Editors #
abbr --add v nvim
abbr --add c code
alias svi="sudo vim -u ~/.dotfiles/common/vim.noxdg.vimrc" # Prevent conflicts with svelte-cli

# Dev #
abbr --add py python3
abbr --add ipy ipython

abbr --add g lazygit

# lsd - modern ls
if command -v lsd > /dev/null
    alias ls='lsd'
    abbr --add l 'lsd -lah'
    abbr --add ll 'lsd -l'
    abbr --add la 'lsd -A'
    abbr --add l. 'lsd -d .*'
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

# Create a new file, if the directory does not exist, create it
# Arg: a file name
function mt
    mkdir -p (dirname $argv[1]) && touch $argv[1]
end

function mtv
    mkdir -p (dirname $argv[1]) && touch $argv[1] && nvim $argv[1]
end

function catclip
    cat $argv | clip
end

abbr --add bcat "bat --style=plain"

# Use neovide as gVim
abbr --add gvi "neovide"

if command -v brew > /dev/null
    abbr --add brewi "brew install"
    abbr --add brewu "brew upgrade && brew update"
    abbr --add brewr "brew remove"
    abbr --add brewc "brew cleanup"
    abbr --add brewl "brew list"
end

if command -v pacman > /dev/null
    abbr --add pac "sudo pacman"
    abbr --add paci "sudo pacman -S"
    abbr --add pacr "sudo pacman -R"
    abbr --add pacu "sudo pacman -Syu"
    abbr --add pacl "pacman -Q"
    if command -v paru > /dev/null
        abbr --add pacs "paru -Ss"
    else if command -v yay > /dev/null
        abbr --add pacs "yay -Ss"
    else
        abbr --add pacs "pacman -Ss"
    end
end

if command -v apt > /dev/null
    abbr --add apt "sudo apt"
    abbr --add apti "sudo apt install"
    abbr --add aptr "sudo apt remove"
    abbr --add aptu "sudo apt update && sudo apt upgrade"
    abbr --add apts "apt search"
    abbr --add aptl "apt list --installed"
end

if test "$TERM" = "xterm-ghostty" -o "$TERM" = "xterm-kitty"
    abbr --add icat "kitten icat"
else if test "$TERM_PROGRAM" = "WezTerm"
    if test "$WSL_DISTRO_NAME"
        abbr --add icat "wezterm.exe imgcat"
    else
        abbr --add icat "wezterm imgcat"
    end
end

# Bash Style Command Substitution
# https://github.com/fish-shell/fish-shell/wiki/Bash-Style-Command-Substitution-and-Chaining-(!!-!$)

function __last_history_item; echo $history[1]; end

abbr -a !! --position anywhere --function __last_history_item
