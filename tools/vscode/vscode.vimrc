" ~/.config/vscode/vscode.vimrc
" New-Item -ItemType SymbolicLink -Path ~\.config\vscode\vscode.vimrc -Target ~\.dotfiles\vscode\vscode.vimrc
" ln -sf $DOTFILES/vscode/vscode.vimrc $XDG_CONFIG_HOME/vscode/vscode.vimrc
" And go to vscode vim setting:
"vim.vimrc.path": "$HOME/.config/vscode/vscode.vimrc",


" Use VSpaceCode instead of <leader>
noremap <space> vspacecode.space

" Arrow remap
noremap n j
noremap e k
noremap i l

" Switch between tabs
noremap H :bprevious<CR>
noremap I :bnext<CR>

noremap N 5j
noremap E 5k

" Similar position to i
" The `noremap` implements text-object-like behavior in VSCodeVim
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

" Define in settings.json, since this will remap <esc> under visual mode
" noremap <esc> :nohlsearch<CR>

" 分词版本的w和b，支持中文，需要插件
" 为了保证递归解析，而不是打断，使用 `nmap` 而不是 `nnoremap`
" Comment if you don't use cjk or the plugin
nmap w cjkWordHandler.cursorWordEndRight
nmap b cjkWordHandler.cursorWordStartLeft

" keep selection after indent (define in settings.json)
" voremap < <gv
" voremap > >gv

" lsp
noremap gi editor.action.goToImplementation
noremap gpi editor.action.peekImplementation
noremap gd editor.action.goToDefinition
noremap gpd editor.action.peekDefinition
noremap gt editor.action.goToTypeDefinition
noremap gpt editor.action.peekTypeDefinition
noremap gh editor.action.showDefinitionPreviewHover
