vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

local bufmap = {
  { mode = "x", keys = "i", cmd = 'c*<C-r>"*', opt = { desc = "Add italic to selected text" } },
  { mode = "x", keys = "b", cmd = 'c**<C-r>"**', opt = { desc = "Add bold to selected text" } },
  { mode = "x", keys = "c", cmd = 'c`<CR><C-r>"<CR>`', opt = { desc = "Add code block to selected text" } },
  { mode = "x", keys = "d", cmd = 'c~~<C-r>"~~', opt = { desc = "Add strikethrough to selected text" } },
  { mode = "x", keys = "h", cmd = 'c==<C-r>"==', opt = { desc = "Add highlight to selected text" } },
}

-- local set_buf_keymaps_prefix = require("keymaps.utils").set_buf_keymaps_prefix
local set_buf_keymaps = require("keymaps.utils").set_buf_keymaps

set_buf_keymaps(bufmap)
