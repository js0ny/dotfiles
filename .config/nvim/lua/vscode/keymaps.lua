local keymap = vim.keymap.set

vim.g.mapleader = " "

vim.keymap.set({ "n", "v", "", "s", "x" }, "e", "k", { desc = "move cursor ⇧" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "n", "j", { desc = "move cursor ⇩" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "h", "h", { desc = "move cursor ⇦" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "i", "l", { desc = "move cursor ⇨" })

vim.keymap.set({ "n", "v", "", "s", "x" }, "N", "J", { desc = "Insert at the line start" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "E", "K", { desc = "Insert at the line start" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "I", "L", { desc = "Insert at the line start" })

vim.keymap.set({ "n", "v", "", "s", "x" }, "l", "i", { desc = "Insert mode" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "L", "I", { desc = "Insert at the line start" })

vim.keymap.set({ "n", "v", "", "s", "x" }, "k", "n", { desc = "Insert at the line start" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "K", "N", { desc = "Insert at the line start" })

vim.keymap.set({ "n", "v", "", "s", "x" }, "j", "e", { desc = "Insert at the line start" })
vim.keymap.set({ "n", "v", "", "s", "x" }, "J", "E", { desc = "Insert at the line start" })

vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.tabstop = 5
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 3
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

-- VSCode commands
keymap({ "n", "v" }, "<leader>pp", "<cmd>lua require('vscode').action('workbench.view.extension.project-manager')<CR>")
keymap({ "n", "v" }, "<leader>pP", "<cmd>lua require('vscode').action('projectManager.listProjects')<CR>")
