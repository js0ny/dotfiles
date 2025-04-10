" $XDG_CONFIG_HOME/vim/vimrc
" This is a minimal setup of vimrc
" ln -sf $DOTFILES/.config/vim/vimrc $XDG_CONFIG_HOME/vim/vimrc

" Colemak Keys

" Arrow remap
nnoremap J 5j
nnoremap K 5k
vnoremap H ^
xnoremap H ^
onoremap H ^
vnoremap L $
xnoremap L $
onoremap L $

" Normal minimal setup

noremap Y y$
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set wrap
set scrolloff=3
set hlsearch
set incsearch
set ignorecase
set smartcase

set number
set relativenumber

set laststatus=2
set showcmd
set statusline=%<%f\ %h%m%r\ %=\ [%l,%v]\ [%p%%]\ [\ %Y]\ [󱑉\ %{strftime('%H:%M:%S')}]


" XDG Directory Specifications
" Reference to https://jorenar.com/blog/vim-xdg

if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME."/.cache"       | endif
if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME."/.config"      | endif
if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME."/.local/share" | endif
if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME."/.local/state" | endif

set viminfo+=n$XDG_STATE_HOME/vim/viminfo
set packpath^=$XDG_DATA_HOME/vim
set packpath+=$XDG_DATA_HOME/vim/after
set backupdir=$XDG_STATE_HOME/vim/backup
set directory=$XDG_STATE_HOME/vim/swap
set undodir=$XDG_STATE_HOME/vim/undo
set viewdir=$XDG_STATE_HOME/vim/view
" set shada+=n$XDG_STATE_HOME/vim/shada
" Leader
let mapleader = "\<Space>"
nnoremap <leader><leader> :FZF<CR>
" Misc
syntax on
