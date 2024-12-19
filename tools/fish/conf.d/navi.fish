

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

abbr --add \- 'cd -'

if command -v zoxide > /dev/null
    zoxide init fish | source
end
