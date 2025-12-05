local M = {}
-- local keymaps_user_command = require("keymaps.user-command")
require("keymaps.user-command")
local utils = require("keymaps.utils")

local keymaps_general = vim.tbl_extend("force", {}, require("keymaps.leaders"), require("keymaps.lspkeys"))
-- Tables cannot be merged since `mode` are set in some keymaps of `keymaps_basic`
local keymaps_basic = require("keymaps.basic")
local keymaps_modifier = require("keymaps.modifier")
local keymaps_terminal = require("keymaps.tmap")

-- require("keymaps.buffer")

utils.set_keymaps(keymaps_general)
utils.set_keymaps(keymaps_basic)
utils.set_keymaps(keymaps_modifier)
utils.set_keymaps(keymaps_terminal)

-- Added in neovim 0.11
-- vim.keymap.del({ "n", "x" }, "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del({ "n" }, "gri")

-- which-key.nvim
if vim.g.loaded_which_key then
  require("keymaps.which")
end

return M
