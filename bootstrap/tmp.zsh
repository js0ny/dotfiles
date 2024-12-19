export DOTFILES=~/.dotfiles
export ZDOTDIR=~/.config/zsh

mkdir -p $ZDOTDIR
mkdir -p $DOTFILES

git clone https://github.com/js0ny/dotfiles $DOTFILES

sudo cp $DOTFILES/tools/zsh/global.zshenv /etc/zsh/zshenv

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"


mkdir -p $XDG_CONFIG_HOME $XDG_DATA_HOME $XDG_STATE_HOME $XDG_CACHE_HOME

