" ~/.config/vscode/vscode.vimrc
" New-Item -ItemType SymbolicLink -Path ~\.config\vscode\vscode.vimrc -Target ~\.dotfiles\vscode\vscode.vimrc
" mkdir -p ~/.config/vscode && ln -sf ~/.dotfiles/vscode/vscode.vimrc ~/.config/vscode/vscode.vimrc
" And go to vscode vim setting:
    "vim.vimrc.path": "$HOME/.config/vscode/vscode.vimrc",

" Word wrap
noremap n gj
noremap e gk
noremap i l

" Similar position to i
noremap l i
noremap L I
" ne[k]st
noremap k n
noremap K N
" [j]ump 
noremap j e
noremap J E

" Y to yank to end of line
noremap Y y$