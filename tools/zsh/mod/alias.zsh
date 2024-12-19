# $DOTFILES/tools/zsh/mod/alias.zsh
# Date: 2024-11-30
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# PowerShell Equivalent, for cross-platform compatibility
alias ni=touch
alias cls=clear
alias ii=open

# Dev #
alias gpp='g++ -std=c++2b' # Set the default C++ standard to C++20
alias gcc='gcc -std=c99' # Set the default C standard to C99
alias cl='clang -std=c99'
alias clpp='clang++ -std=c++2b'
alias python=python3 # Set the default Python version to Python 3
alias py=python # Alias for Python
alias pip=pip3 # Alias for pip
# alias bashcfg="nvim ~/.bashrc"
alias zshcfg="nvim $ZDOTDIR/.zshrc"
alias shcfg=zshcfg
alias reload="source $ZDOTDIR/.zshrc"
alias nvimrc="nvim $XDG_CONFIG_HOME/nvim/"
alias pulldots="cd $DOTFILES && git pull"

# Editors #
alias v=nvim
alias c=code
alias sv="sudo vim -u ~/.config/vim/vimrc"
alias sn="sudo nvim -u ~/.config/nvim/init.lua"

# lsd - modern ls
if command -v lsd > /dev/null; then
    alias ls='lsd -A -I .DS_Store -I .git'
    alias l='lsd -lah'
    alias ll='lsd -l'
    alias tree='lsd --tree -I .DS_Store -I .git -A'
fi

# fzf - Fuzzy Finder
# export FZF_DEFAULT_OPTS_FILE=~/.dotfiles/common/fzfrc

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

# Use neovide as gVim
gvi() {
  local target=$1

  if command -v neovide.exe > /dev/null; then
    neovide.exe "$target"
  else
    if command -v neovide > /dev/null; then
      neovide "$target"
    else
      echo "neovide is not installed"
    fi
  fi
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
    alias aptr="sudo apt autoremove && sudo apt remove"
fi

if command -v brew > /dev/null; then
    alias brewi="brew install"
    alias brewu="brew update && brew upgrade"
    alias brewc="brew cleanup"
    alias brewr="brew uninstall"
fi

alias -s {htm,html,css,scss,js,jsx,ts,tsx,json,jsonc}=code
alias -s {md,markdown}=code
alias -s {py,sh,rb,pl,php,java,c,cpp,h,hpp}=nvim
alias -s {cs,csx,fs,fsx,razor}=code
