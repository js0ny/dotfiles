# $DOTFILES/tools/zsh/mod/alias.zsh
# Date: 2024-11-30
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# PowerShell Equivalent, for cross-platform compatibility
alias ni=touch
alias cls=clear
alias ii=open

# Editors #
alias v=nvim
alias c=code
# Use neovide as gVim
alias gvi="neovide"
alias sv="sudo vim -u ~/.dotfiles/common/vim.noxdg.vimrc"
alias sn="sudo nvim -u ~/.config/nvim/init.lua"

# Dev #
alias gpp='g++ -std=c++2b' # Set the default C++ standard to C++20
alias gcc='gcc -std=c99' # Set the default C standard to C99
alias cl='clang -std=c99'
alias clpp='clang++ -std=c++2b'
alias python=python3 # Set the default Python version to Python 3
alias py=python
alias ipy=ipython

alias reload="source $ZDOTDIR/.zshrc"


# lsd - modern ls
if command -v lsd > /dev/null; then
    alias ls='lsd -A'
    alias l='lsd -lah'
    alias ll='lsd -l'
    alias tree='lsd --tree -A'
else
    alias l='ls -lah'
    alias ll='ls -l'
fi


# Functions #
mkcd() {
  mkdir -p $1 && cd $1
}
cdls(){
	cd $1 && ls
}
tc(){
	touch $1 && code $1
}
tv(){
	touch $1 && nvim $1
}
mt(){
    mkdir -p $(dirname $1) && touch $1
}


alias update="source $DOTFILES/scripts/update.zsh"

if command -v pacman > /dev/null; then
    alias pac="sudo pacman"
    alias paci="sudo pacman -S"
    alias pacr="sudo pacman -R"
    alias pacu="sudo pacman -Syu"
fi

if command -v apt > /dev/null; then
    alias apt="sudo apt"
    alias apti="sudo apt install"
    alias aptu="sudo apt update && sudo apt upgrade"
    alias aptr="sudo apt remove"
fi

if command -v brew > /dev/null; then
    alias brewi="brew install"
    alias brewu="brew update && brew upgrade"
    alias brewc="brew cleanup"
    alias brewr="brew uninstall"
fi


# `-s` suffix alias
# % readme.md -> glow readme.md
alias -s {md,markdown}=glow
alias -s {htm,html,css,scss,js,jsx,ts,tsx,json,jsonc}=code
alias -s {py,rb,pl,php,java,c,cpp,h,hpp}=nvim
alias -s {cs,csx,fs,fsx,razor}=code

# TODO: Does not work
if [ "$TERM" = "xterm-ghostty" ] || [ "$TERM" = "xterm-kitty" ]; then
    alias icat="kitten icat"
elif [ "$TERM_PROGRAM" = "WezTerm" ]; then
    if [ -n "$WSL_DISTRO_NAME" ]; then
        alias icat="wezterm.exe imgcat"
    else
        alias icat="wezterm imgcat"
    fi
fi
