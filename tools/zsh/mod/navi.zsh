# $DOTFILES/tools/zsh/mod/navi.zsh
# Date: 2024-12-01
# Author: contact@js0ny.net
# Sourced by user's zshrc 在用户的 zshrc 中被引用

# Relative navigation #
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Use `-` to jump to the previous directory
# Oh-My-Zsh defines a similar one
function - { cd - }

# Use `z` to jump to a directory
eval "$(zoxide init zsh)"

# Absolute navigation #
alias dotfiles="cd $DOTFILES && ls"
if [ "$IS_WSL" = true ]; then # IS_WSL is defined in $DOTFILES/platforms/wsl/zshrc
    winuser=$(whoami.exe | cut -d'\' -f2 | tr -d '\r')
    alias dt="cd /mnt/c/Users/$winuser/Desktop && ls"
    alias doku="cd /mnt/c/Users/$winuser/Documents && ls"
    alias down="cd /mnt/c/Users/$winuser/Downloads && ls"
    alias src="cd /mnt/d/Source"
    alias one="cd /mnt/c/Users/$winuser/OneDrive"
    alias gdrive="cd /mnt/g"
else
    alias dt="cd $HOME/Desktop && ls"
    alias doku="cd $HOME/Documents && ls"
    alias down="cd $HOME/Downloads && ls"
    alias src="cd $HOME/Documents/Source"
fi

# macOS specific, no OneDrive & Google Drive on Linux
if [ "$(uname)" = "Darwin" ]; then
    alias one="cd $HOME/OneDrive"
    alias gdrive="cd $HOME/Google\ Drive"
fi
