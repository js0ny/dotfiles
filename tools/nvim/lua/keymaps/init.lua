local M = {}
-- local keymaps_user_command = require("keymaps.user-command")
require("keymaps.user-command")
local utils = require("keymaps.utils")

local keymaps_nvim_tree_general = require("keymaps.nvim-tree").global

local keymaps_general = vim.tbl_extend("force", {}, require("keymaps.leaders"), require("keymaps.lspkeys"))
-- Tables cannot be merged since `mode` are set in some keymaps of `keymaps_basic`
local keymaps_basic = require("keymaps.basic")
local keymaps_modifier = require("keymaps.modifier")

require("keymaps.buffer")

utils.set_keymaps(keymaps_general)
utils.set_keymaps(keymaps_basic)
utils.set_keymaps(keymaps_nvim_tree_general)
utils.set_keymaps(keymaps_modifier)

M.nvim_tree_keymaps = require("keymaps.nvim-tree").plugin

-- local function set_markdown_keymaps(bufnr)
--   local opts = { noremap = true, silent = true, buffer = bufnr }
--   vim.keymap.set("v", "`", 'c`<C-r>"`<Esc>', opts)
-- end

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     set_markdown_keymaps(0)
--   end,
-- })

-- which-key.nvim
if vim.g.loaded_which_key then
  require("keymaps.which")
end
require("keymaps.visual-multi")

return M
