# $XDG_CONFIG_HOME/zsh/.zshrc
# ln -s $DOTFILES/mac/.zshrc $XDG_CONFIG_HOME/zsh/.zshrc
### Variables ###

export DOTFILES="$HOME/.dotfiles"
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
for file in $DOTFILES/zsh/*.zsh; do
  source $file
done
export ARCHFLAGS="-arch arm64"

### Navigation ###
# Absolute navigation
alias doku="cd ~/doku && ls"
alias dotfiles="cd $DOTFILES && ls"
alias docs="cd ~/Documents"
alias dt="cd ~/Desktop"
alias down="cd ~/Downloads"
alias one="cd ~/OneDrive"
alias gdrive="cd ~/Google\ Drive"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('$HOME/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
