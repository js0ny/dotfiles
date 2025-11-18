" ~/.config/vscode/vscode.vimrc
" New-Item -ItemType SymbolicLink -Path ~\.config\vscode\vscode.vimrc -Target ~\.dotfiles\vscode\vscode.vimrc
" ln -sf $DOTFILES/vscode/vscode.vimrc $XDG_CONFIG_HOME/vscode/vscode.vimrc
" And go to vscode vim setting:
"vim.vimrc.path": "$HOME/.config/vscode/vscode.vimrc",

" For all available options see
" https://github.com/VSCodeVim/Vim/blob/d41e286e9238b004f02b425d082d3b4181d83368/src/configuration/vimrc.ts#L120-L407


" Use VSpaceCode instead of <leader>
noremap <space> vspacecode.space


" Switch between tabs
nnoremap H :bprevious<CR>
nnoremap L :bnext<CR>
vnoremap H ^
xnoremap H ^
onoremap H ^
vnoremap L $
xnoremap L $
onoremap L $


noremap J 5j
noremap K 5k

" Similar position to i
" The `noremap` implements text-object-like behavior in VSCodeVim

" Y to yank to end of line
noremap Y y$

nnoremap <esc> removeSecondaryCursors


" lsp
noremap gi editor.action.goToImplementation
noremap gpi editor.action.peekImplementation
noremap gd editor.action.goToDefinition
noremap gpd editor.action.peekDefinition
noremap gt editor.action.goToTypeDefinition
noremap gpt editor.action.peekTypeDefinition
noremap gh editor.action.showDefinitionPreviewHover
noremap gr editor.action.goToReferences
noremap gpr editor.action.referenceSearch.trigger
noremap ga editor.action.quickFix

" Rename, or [c]hange [d]efinition
nnoremap cd editor.action.rename

" Requires matchit by redguardtoo
" nnoremap % extension.matchitJumpItems

noremap zR editor.foldAll

" keep selection after indent
vnoremap < editor.action.outdentLines
vnoremap > editor.action.indentLines

nnoremap [g editor.action.editor.previousChange
nnoremap ]g editor.action.editor.nextChange

" 分词版本的w和b，支持中文，需要插件
" 为了保证递归解析，而不是打断，使用 `nmap` 而不是 `nnoremap`
" Comment if you don't use cjk or the plugin
" This is buggy
"nmap w cjkWordHandler.cursorWordEndRight
"nmap b cjkWordHandler.cursorWordStartLeft

" <C-w> will be parsed by VSCode itself.
" noremap <C-w>n <C-w>j
" noremap <C-w>e <C-w>k
" noremap <C-w>i <C-w>l
" noremap <C-w>x workbench.action.toggleEditorGroupLayout
" " Use C-w C-w as original C-w
" noremap <C-w><C-w> workbench.action.closeActiveEditor
" noremap <C-w><A-n> workbench.action.togglePanel

" camelCaseMotion
noremap w <leader>w