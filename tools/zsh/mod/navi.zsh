# $DOTFILES/tools/zsh/mod/navi.zsh
# Date: 2024-12-01
# Author: js0ny
# Sourced by user's zshrc 在用户的 zshrc 中被引用


# Define __CD_CMD as "cd" by default
__CD_CMD="cd"

# If zoxide is available, use it
if command -v zoxide >/dev/null; then
    __CD_CMD="z"
    eval "$(zoxide init zsh)"
fi

# Define aliases for quick navigation
alias ..="$__CD_CMD .."
alias ...="$__CD_CMD ../.."
alias ....="$__CD_CMD ../../.."
alias .....="$__CD_CMD ../../../.."
alias ......="$__CD_CMD ../../../../.."

# Abbreviation for "cd -"
alias - "$__CD_CMD -"

# Define zls function for cd + ls
zls() {
    "$__CD_CMD" "$1" && ls
}
alias cdls=zls

# Quick Jump Directories
[[ -d "$DOTFILES" ]] && alias dot="$__CD_CMD $DOTFILES"
[[ -d "$HOME/Downloads" ]] && alias down="$__CD_CMD $HOME/Downloads"
[[ -d "$HOME/.config" ]] && alias conf="$__CD_CMD $HOME/.config"
[[ -d "$HOME/Obsidian" ]] && alias ob="$__CD_CMD $HOME/Obsidian"
[[ -d "$HOME/Source" ]] && alias src="$__CD_CMD $HOME/Source"
[[ -d "$HOME/Source/Scripts" ]] && alias scr="$__CD_CMD $HOME/Source/Scripts"
[[ -d "$HOME/OrgFiles" ]] && alias org="$__CD_CMD $HOME/OrgFiles"
