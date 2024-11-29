
# Relative navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

function - { cd - }

eval "$(zoxide init zsh)"
