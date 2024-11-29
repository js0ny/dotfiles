local M = {}
local global_default_opts = { noremap = true, silent = true }
local global_default_mode = { "n" }
-- local mode_arrow = { "n", "v", "o", "s", "x" }

local function set_keymaps(maps, default_opts, default_mode)
  for _, map in ipairs(maps) do
    local opts = vim.tbl_extend("force", default_opts, map.opts or {})
    local mode = map.mode or default_mode
    vim.keymap.set(mode, map.keys, map.cmd, opts)
  end
end



local keymaps_basic = require("keymaps.basic")
local keymaps_nvim_tree_general = require("keymaps.nvim-tree").global
local keymaps_leader = require("keymaps.leaders")

set_keymaps(keymaps_basic, global_default_opts, global_default_mode)
set_keymaps(keymaps_nvim_tree_general, global_default_opts, global_default_mode)
set_keymaps(keymaps_leader, global_default_opts, global_default_mode)

M.nvim_tree_keymaps = require("keymaps.nvim-tree").plugin

--- `map` default for `cmp.mapping`
function M.cmp_nvim_keymaps(map)
  return {
    { keys = "<C-n>",     cmd = map.select_next_item(),         desc = "Select next completion item" },
    { keys = "<C-p>",     cmd = map.select_prev_item(),         desc = "Select previous completion item" },
    { keys = "<C-y>",     cmd = map.confirm({ select = true }), desc = "Confirm completion" },
    { keys = "<Tab>",     cmd = map.confirm({ select = true }), desc = "Confirm completion" },
    { keys = "<C-Space>", cmd = map.complete(),                 desc = "Trigger completion" },
    { keys = "<C-e>",     cmd = map.abort(),                    desc = "Abort completion" },
  }
end

return M
