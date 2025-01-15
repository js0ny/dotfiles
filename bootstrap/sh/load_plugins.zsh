set -e
ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
mkdir -p $ZDOTDIR/plugins

#plugins=(
#    "zsh-autosuggestions"
#    "zsh-syntax-highlighting"
#    "zsh-history-substring-search"
#)
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZDOTDIR/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git $ZDOTDIR/plugins/zsh-history-substring-search
