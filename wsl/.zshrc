# $XDG_CONFIG_HOME/zsh/.zshrc
# ln -s $DOTFILES/wsl/.zshrc $XDG_CONFIG_HOME/zsh/.zshrc
### Variables ###

export DOTFILES="$HOME/.dotfiles"
for file in $DOTFILES/zsh/*.zsh; do
  source $file
done
export ARCHFLAGS="-arch x86_64"

# Absolute navigation
alias src="cd ~/Source && ls"
alias dotfiles="cd $DOTFILES && ls"


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


if [ -f /usr/share/doc/pkgfile/command-not-found.sh ]; then
    source /usr/share/doc/pkgfile/command-not-found.sh
fi


# vcpkg

export VCPKG_ROOT=~/vcpkg