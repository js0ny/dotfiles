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
alias nvimrc="nvim $XDG_CONFIG_HOME/nvim/"
alias ohmyzsh="code ~/.oh-my-zsh"
alias pulldots="cd $DOTFILES && git pull"

# Conda #
alias pyact="conda activate"
alias pydact="conda deactivate"
alias pylsenv="conda env list"
alias pymkenv="conda create --name"

# Editors #
alias v=nvim
alias c=code

# Misc #
alias cf=cfiles

# Functions #
mcd() {
  mkdir -p -- "$0" && cd -P -- "$1"
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