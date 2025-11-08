# $DOTFILES/tools/zsh/mod/config.zsh
# Date: 2024-11-30
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# ZSH Config, no need to `export` these variables
HISTFILE="$XDG_STATE_HOME"/zsh/history
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000
SAVEHIST=10000

setopt INTERACTIVE_COMMENTS # Allow comments in interactive mode

# Globbing
setopt EXTENDED_GLOB        # Extended globbing
setopt GLOB_DOTS            # Include dotfiles in globbing

# Error correction
setopt CORRECT              # Suggest corrections for commands
setopt CORRECT_ALL          # Suggest corrections for arguments

# Manually manage plugins 手动管理插件
# Load zsh-syntax-highlighting before zsh-history-substring-search
# Reference: https://github.com/zsh-users/zsh-history-substring-search?tab=readme-ov-file#usage
plugins=(
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
  "zsh-history-substring-search"
  "zsh-completions"
)

plugin_dir="$ZDOTDIR/plugins"

for plugin in "${plugins[@]}"; do
  plugin_path="$plugin_dir/$plugin/$plugin.zsh"
  plugin_path_alt="$plugin_dir/$plugin/$plugin.plugin.zsh"
  if [[ -f $plugin_path ]]; then
    source "$plugin_path"
  elif [[ -f $plugin_path_alt ]]; then
    source "$plugin_path_alt"
  else
    echo "Warning: Plugin not found: $plugin_path"
  fi
done

ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main pattern brackets root)
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan,underline'
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=blue,bold,bg=red')

export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython

# https://unix.stackexchange.com/questions/33994/
# Use `set -k` to mark leading `#` as a comment character
set -k

source <(fzf --zsh)
