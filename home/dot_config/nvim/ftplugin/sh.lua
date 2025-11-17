local prefmap = {
  { keys = "x", cmd = '<cmd>!chmod +x "%"<CR>', opts = { desc = "Mark the file as executable" } },
  { keys = "X", cmd = '<cmd>!chmod u+x "%"<CR>', opts = { desc = "Mark the file as executable (current user only)" } },
}

local set_buf_keymaps_prefix = require("keymaps.utils").set_buf_keymaps_prefix
-- local set_buf_keymaps = require("keymaps.utils").set_buf_keymaps

set_buf_keymaps_prefix(prefmap)
