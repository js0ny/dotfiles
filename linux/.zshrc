### Variables ###

export DOTFILES="$HOME/.dotfiles"

### ZSH Config ###
set -o vi
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git web-search jsontools z vi-mode zsh-autosuggestions)
#plugins=(git web-search jsontools z vi-mode zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
# export LANG= "en_US.UTF-8"
export ARCHFLAGS="-arch x86_64"

### Navigation ###

# Relative navigation

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Absolute navigation

alias doku="cd ~/doku && ls"
alias dotfiles="cd $DOTFILES && ls"

### Aliases ###

# `alias` to list all aliases

# PowerShell Equivalent #

alias ni=touch
alias cls=clear

# Dev #

alias g++='g++ -std=c++2b' # Set the default C++ standard to C++20
alias gcc='gcc -std=c99' # Set the default C standard to C99
alias cl='clang -std=c99'
alias clpp='clang++ -std=c++2b'
alias python=python3 # Set the default Python version to Python 3
alias py=python # Alias for Python
alias bashcfg="nvim ~/.bashrc"
alias zshcfg="nvim ~/.zshrc"
alias shcfg=zshcfg
alias reload="source ~/.zshrc"
alias nvimrc="nvim ~/.config/nvim/"
alias ohmyzsh="code ~/.oh-my-zsh"
alias pulldots="cd $DOTFILES && git pull"

# Conda #

alias pyact="conda activate"
alias pylsenvs="conda env list"
alias pydact="conda deactivate"

# Git #




# Editors #

alias v=nvim
alias c=code

# Misc #

alias cf=cfiles

### Functions ###

mcd() {
  mkdir -p -- "$1" && cd -P -- "$1"
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

source ~/.private.env.sh

### WSL Options ###

# WSL open
open() {
  local target=$1

  if command -v explorer.exe > /dev/null; then
    explorer.exe "$target"
  else
    command open "$target"
  fi
}

# WSL Neovide
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

### Misc ###

export PATH=/opt/bin:$PATH

# Conda #

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/js0ny/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/js0ny/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/js0ny/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/js0ny/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Ubuntu Command Not Found #

if [[ -x /usr/lib/command-not-found ]] ; then
        if (( ! ${+functions[command_not_found_handler]} )) ; then
                function command_not_found_handler {
                        [[ -x /usr/lib/command-not-found ]] || return 1
                        /usr/lib/command-not-found -- ${1+"$1"} && :
                }
        fi
fi

# LinuxBrew #

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# Set PATH, MANPATH, etc., for Homebrew.
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/js0ny/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
