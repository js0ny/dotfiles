-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.g.mapleader = " "

-- ================= GENERAL KEYBINDS =================
--  SAVE/QUIT {{{
vim.keymap.set("n", "Q", "<cmd>q<CR>", { desc = "Q to quit" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "S to write file" })
--}}}

-- NVIM CONFIG SHORTCUTS {{{
-- stylua: ignore
vim.keymap.set("n", "<leader>rc", "<cmd>e $HOME/.config/nvim/lua/config/options.lua<CR>", { desc = "Open nvim options.lua" })
vim.keymap.set("n", "<leader>rp", "<cmd>e $HOME/.config/nvim/lua/plugins/.<CR>", { desc = "lazy plugins dir" })
--}}}

--  UNDO
vim.keymap.set({ "n", "v" }, "l", "u", { desc = "Undo" })

-- INSERT
vim.keymap.set({ "n", "v" }, "l", "i", { desc = "Insert" })
vim.keymap.set({ "n", "v" }, "L", "I", { desc = "Insert at line start" })

-- YANK TO SYSTEM CLIPBOARD
vim.keymap.set("v", "Y", '"+y', { desc = "Copy to (System) Clipboard" })

-- SEARCH {{{
vim.keymap.set("n", "<LEADER><CR>", "<CMD>nohlsearch<CR>", { desc = "clear search highlight" })
--}}}

-- SPACE TO TAB{{{
vim.keymap.set("n", "<LEADER>tt", "<CMD>%s/    /\t/g<CR>", { desc = "space to tab" })
vim.keymap.set("v", "<LEADER>tt", "<CMD>s/    /\t/g<CR>", { desc = "space to tab" })
--}}}

-- MISC {{{
vim.keymap.set("n", "<LEADER>o", "za", { desc = "folding" })
vim.keymap.set("i", "<C-y>", "<ESC>A {}<ESC>i<CR><ESC>ko", { desc = "insert a pair of {} and goto next line" })
--}}}

-- ================= CURSOR MOVEMENT ===================== {{{
-- NEW CURSOR MOVEMENT (ARROW KEY RESIZE WINDOWS)
--      ^
--      e
--  < h   i >
--      n
--      v
--
vim.keymap.set({ "n", "v", "", "s", "x" }, "e", "k", { desc = "move cursor ⇧" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "n", "j", { desc = "move cursor ⇩" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "h", "h", { desc = "move cursor ⇦" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "i", "l", { desc = "move cursor ⇨" })

vim.keymap.set({ "n", "v" }, "E", "5k", { desc = "Move 5up K -> U" })
vim.keymap.set({ "n", "v" }, "N", "5j", { desc = "Move 5down J -> E" })

vim.keymap.set({ "n", "v" }, "H", "0", { desc = "Move start of line" })
vim.keymap.set({ "n", "v" }, "I", "$", { desc = "Move end of line" })

vim.keymap.set("n", "gu", "gk", { desc = "move up gk -> gu" })
vim.keymap.set("n", "ge", "gj", { desc = "move down gj -> ge" })

vim.keymap.set("n", "\v", "v$h", { desc = "???" })

-- FASTER IN-LINE NAVIGATION

-- SET h (SAME AS n, CURSOR LEFT) TO 'END OF WORD'
vim.keymap.set("n", "j", "e", { desc = "Move cursor to end of word" })
-- CTRL + U OR E WILL MOVE UP/DOWN THE VIEW PORT WITHOUT MOVING THE CURSOR

vim.keymap.set({ "n", "v" }, "<C-e>", "5<C-y>", { desc = "Move viewport ⇧" })
vim.keymap.set({ "n", "v" }, "<C-n>", "5<C-e>", { desc = "Move viewport ⇩" })

-- INSERT MODE CURSOR MOVEMENT
vim.keymap.set("i", "<C-a>", "<ESC>A")

-- COMMAND MODE CURSOR MOVEMENT
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<M-b>", "<S-Left>")
vim.keymap.set("c", "<M-w>", "<S-Right>")
--}}}

-- ================= SPLIT MANAGMENT ===================== {{{
vim.keymap.set("n", "<C-w>E", "<CMD>set nosplitbelow<CR><CMD>split<CR><CMD>set splitbelow<CR>", { desc = "Split ⇧" })
vim.keymap.set("n", "<C-w>N", "<CMD>set splitbelow<CR><CMD>split<CR>", { desc = "Split ⇩" })
vim.keymap.set("n", "<C-w>H", "<CMD>set nosplitright<CR><CMD>vsplit<CR><CMD>set splitright<CR>", { desc = "Split ⇦" })
vim.keymap.set("n", "<C-w>I", "<CMD>set splitright<CR><CMD>vsplit<CR>", { desc = "Split ⇨" })

vim.keymap.set({ "n", "t" }, "<C-w>e", "<C-w>k", { desc = "Move cursor to split ⇧" })
vim.keymap.set({ "n", "t" }, "<C-w>n", "<C-w>j", { desc = "Move cursor to split ⇩" })
vim.keymap.set({ "n", "t" }, "<C-w>h", "<C-w>h", { desc = "Move cursor to split ⇦" })
vim.keymap.set({ "n", "t" }, "<C-w>i", "<C-w>l", { desc = "Move cursor to split ⇨" })

vim.keymap.set({ "n", "t" }, "<C-e>", "<C-k>", { desc = "Move cursor to split ⇧" })
vim.keymap.set({ "n", "t" }, "<C-n>", "<C-j>", { desc = "Move cursor to split ⇩" })
vim.keymap.set({ "n", "t" }, "<C-h>", "<C-h>", { desc = "Move cursor to split ⇦" })
vim.keymap.set({ "n", "t" }, "<C-i>", "<C-l>", { desc = "Move cursor to split ⇨" })

vim.keymap.set("n", "<up>", "<CMD>res -5<CR>", { desc = "Resize split 0,-5" })
vim.keymap.set("n", "<down>", "<CMD>res +5<CR>", { desc = "Resize split 0,+5" })
vim.keymap.set("n", "<left>", "<CMD>vertical resize +5<CR>", { desc = "Resize split +5,0" })
vim.keymap.set("n", "<right>", "<CMD>vertical resize -5<CR>", { desc = "Resize split -5,0" })

vim.keymap.set("n", "<C-w>H", "<C-w>t<C-w>K", { desc = "Make splits [H]orizontal" })
vim.keymap.set("n", "<C-w>V", "<C-w>t<C-w>H", { desc = "Make splits [V]ertical" })

vim.keymap.set("n", "<C-w>ri", "<C-w>b<C-w>K", { desc = "Rotate splits 90" })
vim.keymap.set("n", "<C-w>rh", "<C-w>b<C-w>H", { desc = "Rotate splits -90" })

vim.keymap.set("n", "<LEADER>q", "<C-w>j<CMD>q<CR>", { desc = "Close Split ⇩ (Below)" })
--}}}

-- TAB MANAGEMENT {{{
vim.keymap.set("n", "<TAB><TAB>", "<CMD>tabe<CR>", { desc = "New [Tab]" })

vim.keymap.set("n", "<TAB>h", "<CMD>-tabnext<CR>", { desc = "Select Tab ⇦" })
vim.keymap.set("n", "<TAB>i", "<CMD>+tabnext<CR>", { desc = "Select Tab ⇨" })

vim.keymap.set("n", "<TAB>H", "<CMD>-tabmove<CR>", { desc = "Tab move ⇦" })
vim.keymap.set("n", "<TAB>I", "<CMD>+tabmove<CR>", { desc = "Tab move ⇨" })

-- NOTE: Doesn't seem to work:
-- vim.keymap.set("n", "<TAB>c", "<CMD>tab split<CR>", { desc = "New Tab from [C]urrent" })
-- vim.keymap.set('n', '<LEADER>dw', '/\(\<\w\+\>\)\_s*\1', {desc='adjacent duplicate words'})

--vim.keymap.del("n", "<C-w>j")
--vim.keymap.del("n", "<C-w>k")
--vim.keymap.del("n", "<C-w>l")
-- }}}

-- =================== TERM BEHAVIORS ====================
vim.keymap.set("t", "<C-n>", "<C-\\><C-n>", { desc = "escape terminal, allowing excmds" })
vim.keymap.set("t", "<C-o>", "<C-\\><C-n><C-o>", { desc = "close terminal" })

--vim: set fdm=marker fdl=0

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-i>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
