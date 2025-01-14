-- <leader> is space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Disable Perl
vim.g.loaded_perl_provider = 0 -- Don't load Perl

vim.g.autoformat = true

local opt = vim.opt

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- Line number
opt.number = true
opt.relativenumber = true

opt.confirm = true

-- Word wrap
opt.linebreak = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.shiftround = true

-- Case
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
-- Terminal GUI
opt.termguicolors = true

-- Fold
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 1

-- Statusline
opt.laststatus = 0

-- Hide Command Line if empty
opt.cmdheight = 0

-- Scroll
opt.scrolloff = 5
opt.sidescrolloff = 10

opt.conceallevel = 2

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
