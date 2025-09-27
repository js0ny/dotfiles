# vim: ft=tmux

bind h select-pane -L
bind n select-pane -D
bind e select-pane -U
bind i select-pane -R
bind -r H resize-pane -L 5
bind -r N resize-pane -D 5
bind -r E resize-pane -U 5
bind -r I resize-pane -R 5
bind C-h select-window -t :-
bind C-i select-window -t :+
