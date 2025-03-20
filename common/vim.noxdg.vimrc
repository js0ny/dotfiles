
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" This is a minimal setup of vimrc
" ln -sf $DOTFILES/.config/vim/vimrc $XDG_CONFIG_HOME/vim/vimrc

" Colemak Keys

" Arrow remap
noremap n j
noremap e k
noremap i l
nnoremap N 5j
nnoremap E 5k
vnoremap H ^
xnoremap H ^
onoremap H ^
vnoremap I $
xnoremap I $
onoremap I $
noremap I L

" Similar position to i
noremap l i
noremap L I
" ne[k]st
noremap k n
noremap K N
" [j]ump
noremap j e
noremap J E

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
set showcmd
set mouse=a            " Enable mouse usage (all modes)

set number
set relativenumber

set laststatus=2
set showcmd
set statusline=%<%f\ %h%m%r\ %=\ [%l,%v]\ [%p%%]\ [\ %Y]\ [󱑉\ %{strftime('%H:%M:%S')}]

syntax on
