" Put this in ~/.vscode.vimrc
" And go to vscode vim setting:
    "vim.vimrc.path": "$HOME/.vscode.vimrc", 

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