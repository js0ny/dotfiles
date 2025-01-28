-- <leader> is space
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- Disable netrw (file explorer) use NvimTree instead
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Disable Perl
vim.g.loaded_perl_provider = 0 -- Don't load Perl

-- Format on save
vim.g.autoformat = true

local opt = vim.opt

-- Clipboard
-- `unnamedplus` for system clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
-- Line number
opt.number = true
opt.relativenumber = true

-- Confirm before dangerous operations
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

-- Highlight current line
opt.cursorline = true
-- opt.cursorcolumn = true -- Highlight current column
-- Terminal GUI
opt.termguicolors = true

--- Fold
opt.foldmethod = "expr"
-- Folding provided by treesitter
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldlevelstart = 1

-- Disable status line: Use `lualine` instead
opt.laststatus = 0

-- Hide Command Line if empty
opt.cmdheight = 0

-- Scroll
opt.scrolloff = 5      -- Always show 5 lines above/below cursor
opt.sidescrolloff = 10 -- Always show 10 columns left/right of cursor

-- Conceal: Hide some characters, might be useful for markdown and LaTeX
opt.conceallevel = 2

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
