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
alias svi="sudo vim -u ~/.dotfiles/common/vim.noxdg.vimrc" # Prevent conflicts with svelte-cli
alias sn="sudo nvim -u ~/.config/nvim/init.lua"

# Dev #
alias gpp='g++ -std=c++2b' # Set the default C++ standard to C++20
alias gcc='gcc -std=c99' # Set the default C standard to C99
alias cl='clang -std=c99'
alias clpp='clang++ -std=c++2b'
alias python=python3 # Set the default Python version to Python 3
alias py=python
alias ipy=ipython

alias g=lazygit


# lsd - modern ls
if command -v lsd >/dev/null 2>&1; then
    alias ls='lsd'
    alias l='lsd -lah'
    alias ll='lsd -l'
    alias la='lsd -A'
    alias l.='lsd -d .*'
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
mtv(){
    mkdir -p $(dirname $1) && touch $1 && nvim $1
}


alias update="source $DOTFILES/scripts/update.zsh"

if command -v pacman >/dev/null 2>&1; then
    alias pac="sudo pacman"
    alias paci="sudo pacman -S"
    alias pacr="sudo pacman -R"
    alias pacu="sudo pacman -Syu"
    alias pacl="pacman -Q"
    if command -v paru >/dev/null 2>&1; then
        alias pacs="paru -Ss"
    elif command -v yay >/dev/null 2>&1; then
        alias pacs="yay -Ss"
    else
        alias pacs="pacman -Ss"
    fi
fi

if command -v apt >/dev/null 2>&1; then
    alias apt="sudo apt"
    alias apti="sudo apt install"
    alias aptr="sudo apt remove"
    alias aptu="sudo apt update && sudo apt upgrade"
    alias apts="apt search"
    alias aptl="apt list --installed"
fi

if command -v brew >/dev/null 2>&1; then
    alias brewi="brew install"
    alias brewr="brew uninstall"
    alias brewu="brew update && brew upgrade"
    alias brews="brew search"
    alias brewl="brew list"
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
