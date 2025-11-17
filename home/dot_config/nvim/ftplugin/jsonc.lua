local prefmap = {
  { keys = "p", cmd = "<cmd>%!jq<CR>", opts = { desc = "Mark the file as executable" } },
}

local set_buf_keymaps_prefix = require("keymaps.utils").set_buf_keymaps_prefix
-- local set_buf_keymaps = require("keymaps.utils").set_buf_keymaps

set_buf_keymaps_prefix(prefmap)
