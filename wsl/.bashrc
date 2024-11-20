# Append to original bashrc for minimal setup
# echo $DOTFILES/wsl/.bashrc >> ~/.bashrc
set -o vi

bind '"\en": "\C-j"'  
bind '"\ee": "\C-k"'  
bind '"\ei": "\C-l"'  

bind '"\el": "\ei"'   
bind '"\eL": "\eI"'   

bind '"\ek": "\en"'   
bind '"\eK": "\eN"'   

bind '"\ej": "\ee"'   
bind '"\eJ": "\eE"'   

bind '"\eY": "\ey$"'