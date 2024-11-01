"$XDG_CONFIG_HOME/ideavim/ideavimrc
" New-Item -ItemType SymbolicLink -Path ~\.ideavimrc -Target $DOTFILES\.config\ideavim\ideavimrc.vimrc
" ln -sf $DOTFILES/.config/ideavim/ideavimrc.vimrc $XDG_CONFIG_HOME/ideavim/ideavimrc 
""" Basic Configs """
let mapleader = " " " set <leader> to <space>

""" Colemak """
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

""" Options """
" search for actions: :actionlist <patter>

"" Vim Compat ""
set clipboard=unnamedplus,unnamed,ideaput " integrate with system clipboard
set gdefault                      " substitute all occurrences in line per default
set history=4096                  " keep x lines of command line history
set hlsearch
set ignorecase
set incsearch
set keymodel=startsel,stopsel
set matchpairs+=<:>
set showcmd
set smartcase                     " no ignore case when pattern is uppercase
set wrapscan                      " searches wrap around the end of the file

"" IDE Settings ""
set scrolloff=5
set sidescrolloff=10

"" IDE Features ""
set relativenumber " Hybrid Line Number shown

"" IdeaVim Only ""
set ideajoin
set ideastatusicon=enabled

""" Plugins """

Plug 'justinmk/vim-sneak'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'terryma/vim-multiple-cursors'
Plug 'machakann/vim-highlightedyank'
Plug 'easymotion/vim-easymotion'

""" Keybindings """

"" edit ideavim config <leader>v + ""
nnoremap <leader>vv :e ~/.ideavimrc<CR>
nnoremap <leader>vr :source ~/.ideavimrc<CR>

"" NERDTree ""
nnoremap <leader>e :NERDTreeToggle<CR>

"" EasyMotion ""
nmap s <Plug>(easymotion-f)
nmap S <Plug>(easymotion-F)

"" Sneak ""
nmap f <Plug>(sneak-s)
nmap F <Plug>(sneak-S)

"" Miscs ""
nnoremap <leader>: :action GotoAction<CR>

"" AI Related <leader>a + ""
nnoremap <leader>ac :action copilot.chat.show<CR>
nnoremap <leader>ad :action copilot.disableCopilot<CR>
nnoremap <leader>ae :action copilot.enableCopilot<CR>
nnoremap <leader>ai :action copilot.openCopilot<CR>

"" Codes Action <leader>c + ""
nnoremap <leader>cf :action ReformatCode<CR>
nnoremap <leader>cs :action GotoSymbol<CR>
nnoremap <leader>c/ :action CommentByLineComment<CR>

"" Project Action <leader>p + ""
nnoremap <leader>pr :action Run<CR>
nnoremap <leader>pd :action Debug<CR>
nnoremap <leader>pb :action Build<CR>

"" Files Action <leader>f + ""
nnoremap <leader>fe :NERDTreeToggle<CR>
nnoremap <leader>ft :action ActivateTerminalToolWindow<CR>

"" Tab Actions <leader><tab> + ""
nnoremap <leader><tab><tab> :action Switcher<CR>

"" Collapse and Expand z + ""
nnoremap zi :action ExpandCollapseToggleAction<CR>
nnoremap zc :action CollapseRegion<CR>
nnoremap zC :action CollapseRegionRecursively<CR>
nnoremap zM :action CollapseAll<CR>
nnoremap zo :action ExpandRegion<CR>
nnoremap zO :action ExpandRegionRecursively<CR>
nnoremap zR :action ExpandAll<CR>

"" don't lose selection when indenting ""
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv


nnoremap <leader>a :action FindInPath<CR>
nnoremap gd :action GotoDeclaration<CR>
nnoremap gtd :action GotoTypeDeclaration<CR>
nnoremap gtD :action QuickTypeDefinition<CR>
nnoremap gr :action ShowUsages<CR>
nnoremap gi :action GotoImplementation<CR>
nnoremap gpi :action QuickImplementations<CR>
nnoremap gs :action GotoSuperMethod<CR>
nnoremap ga :action
nnoremap gq :action ShowIntentionActions<CR>
nnoremap ge :action GotoNextError<CR>

nnoremap <C-p> :action ParameterInfo<CR>
inoremap <C-p> <C-o>:action ParameterInfo<CR>

"" Refractor <leader>r + ""

nnoremap <leader>ri :action Inline<CR>
nnoremap <leader>rr :action RenameElement<CR>
nnoremap <leader>rev :action IntroduceVariable<CR>
vnoremap <leader>rev :action IntroduceVariable<CR>
nnoremap <leader>rem :action ExtractMethod<CR>
vnoremap <leader>rem :action ExtractMethod<CR>
nnoremap <leader>rm :action Move<CR>
nnoremap <leader>ro :action OptimizeImports<CR>
nnoremap <leader>rG :action Generate<CR>

""" Handling Ctrls """

sethandler <C-V> n-v:vim i:ide
sethandler <C-.> a:ide
sethandler <A-<CR>> a:ide