" ~/.config/vscode/vscode.vimrc
" New-Item -ItemType SymbolicLink -Path ~\.config\vscode\vscode.vimrc -Target ~\.dotfiles\vscode\vscode.vimrc
" ln -sf $DOTFILES/vscode/vscode.vimrc $XDG_CONFIG_HOME/vscode/vscode.vimrc
" And go to vscode vim setting:
"vim.vimrc.path": "$HOME/.config/vscode/vscode.vimrc",

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

" 分词版本的w和b，支持中文，需要插件
" Comment if you don't use cjk or the plugin
noremap w cjkWordHandler.cursorWordEndRight
noremap b cjkWordHandler.cursorWordStartLeft

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

noremap <leader><leader> workbench.action.quickOpen
noremap <leader>: workbench.action.showCommands
" <leader>q : +quit
noremap <leader>qq :quit<CR>
noremap <leader>qQ :qall<CR>
noremap <leader>Q :quit<CR>
" <leader>w : +write/window
noremap <leader>ww :write<CR>
noremap <leader>wa :wall<CR>
noremap <leader>wq :wq<CR>
noremap <leader>W :write<CR>
noremap <leader>wh workbench.action.focusLeftGroup
noremap <leader>wH workbench.action.splitEditorLeft
noremap <leader>wn workbench.action.focusBelowGroup
noremap <leader>wN workbench.action.splitEditorDown
noremap <leader>we workbench.action.focusAboveGroup
noremap <leader>wE workbench.action.splitEditorUp
noremap <leader>wi workbench.action.focusRightGroup
noremap <leader>wI workbench.action.splitEditorRight
" <leader>f : +find/file
noremap <leader>ff workbench.action.quickOpen
noremap <leader>fF workbench.view.search
noremap <leader>fc workbench.action.openSettings
noremap <leader>fC workbench.action.openFolderSettingsFile
noremap <leader>fe workbench.view.explorer
noremap <leader>fr workbench.action.showAllEditorsByMostRecentlyUsed
noremap <leader>fR workbench.action.openRecent
noremap <leader>fs workbench.action.search.toggleQueryDetails
noremap <leader>ft workbench.action.terminal.toggleTerminal
noremap <leader>fx workbench.view.extensions
" <leader>p : +project (requires Project Manager extension)
noremap <leader>pp projectManager.listProjects
noremap <leader>pP projectManager.listAnyProjects#sideBarAny
noremap <leader>pc projectManager.openSettings#sideBarAny
noremap <leader>pe projectManager.editProjects
noremap <leader>pf projectManager.addToFavorites
noremap <leader>pF projectManager.filterProjectsByTag
noremap <leader>pg projectManager.listGitProjects#sideBarGit
noremap <leader>pr workbench.action.openRecent
noremap <leader>ps projectManager.saveProject
" <leader>g : +git
noremap <leader>gg workbench.view.scm
noremap <leader>gS git.stageAll
" <leader>j : +jump
noremap <leader>jj workbench.action.gotoLine
" <leader>l : +language (define in settings.json)
" <leader>u : +ui
noremap <leader>ui workbench.action.selectTheme
noremap <leader>uw editor.action.toggleWordWrap
noremap <leader>uz workbench.action.toggleZenMode
" <leader>a : +ai/action
noremap <leader>aa inlineChat.start
noremap <leader>aA workbench.panel.chat
noremap <leader>ae workbench.action.chat.openEditSession
" <leader>r : +refactor
" <leader>s : +search
" <leader>t : +test
noremap <leader>tt testing.runAll
noremap <leader>tT testing.debugAll
noremap <leader>ta testing.runAll
noremap <leader>tA testing.debugAll
noremap <leader>tf testing.reRunFailedTests
noremap <leader>tF testing.debugFailedTests
noremap <leader>tl testing.reRunLastRun
noremap <leader>tL testing.debugLastRun
noremap <leader>tc testing.runCurrentTest
noremap <leader>tC testing.debugCurrentTest
noremap <leader>tx testing.cancelTestRun
" <leader>d : +debug
" <leader>h : +help
" <leader>c : +code
noremap <leader>cr coderunner.run
noremap <leader>cf editor.action.formatDocument
noremap <leader>c<leader> editor.action.trimTrailingWhitespace
noremap <leader>cs workbench.action.gotoSymbol
noremap <leader>cS workbench.action.showAllSymbols
" <leader>b : +buffer
noremap <leader>bb workbench.action.showAllEditors
noremap <leader>bd :bdelete<CR>
noremap <leader>bh :bprevious<CR>
noremap <leader>bi :bnext<CR>
