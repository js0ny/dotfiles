local M = {}
local keymaps_user_command = require("keymaps.user-command")
local utils = require("keymaps.utils")

local keymaps_nvim_tree_general = require("keymaps.nvim-tree").global

local keymaps_general = vim.tbl_extend("force", {}, require("keymaps.leaders"), require("keymaps.lspkeys"))
-- Tables cannot be merged since `mode` are set in some keymaps of `keymaps_basic`
local keymaps_basic = require("keymaps.basic")
local keymaps_buffer = require("keymaps.buffer")
-- local keymaps_leader = require("keymaps.leaders")
-- local keymaps_lsp = require("keymaps.lspkeys")

utils.set_keymaps(keymaps_general)
utils.set_keymaps(keymaps_basic)
utils.set_keymaps(keymaps_nvim_tree_general)
utils.set_keymaps(keymaps_buffer)

M.nvim_tree_keymaps = require("keymaps.nvim-tree").plugin

--- `map` default for `cmp.mapping`
function M.cmp_nvim_keymaps(map)
  return {
    { keys = "<C-n>", cmd = map.select_next_item(), opts = { desc = "Select next completion item" } },
    { keys = "<C-p>", cmd = map.select_prev_item(), opts = { desc = "Select previous completion item" } },
    { keys = "<C-y>", cmd = map.confirm({ select = true }), opts = { desc = "Confirm completion" } },
    { keys = "<Tab>", cmd = map.confirm({ select = true }), opts = { desc = "Confirm completion" } },
    { keys = "<C-Space>", cmd = map.complete(), opts = { desc = "Trigger completion" } },
    { keys = "<C-e>", cmd = map.abort(), opts = { desc = "Abort completion" } },
  }
end

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
require("keymaps.which")
require("keymaps.visual-multi")

return M
