# $DOTFILES/tools/zsh/mod/config.zsh
# Date: 2024-11-30
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# ZSH Config, no need to `export` these variables
HISTFILE="$XDG_STATE_HOME"/zsh/history
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000
SAVEHIST=10000

export LANG=zh_CN.UTF-8
export LC_ALL=zh_CN.UTF-8


# Manually manage plugins 手动管理插件
# Load zsh-syntax-highlighting before zsh-history-substring-search
# Reference: https://github.com/zsh-users/zsh-history-substring-search?tab=readme-ov-file#usage
plugins=(
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
    "zsh-history-substring-search"
)

plugin_dir="$ZDOTDIR/plugins"

for plugin in "${plugins[@]}"; do
    plugin_path="$plugin_dir/$plugin/$plugin.zsh"
    if [[ -f $plugin_path ]]; then
        source "$plugin_path"
    else
        echo "Warning: Plugin not found: $plugin_path"
    fi
done


# https://unix.stackexchange.com/questions/33994/
# Use `set -k` to mark leading `#` as a comment character
set -k

# # TODO: Below should be reorganized
# export PATH=$HOME/.local/bin:$PATH

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
