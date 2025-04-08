local keymaps_modifier = {
  -- Use C-w to move between windows
  { keys = "<C-w>h", cmd = "<C-w>h",                   opts = { desc = "left Window" } },
  { keys = "<C-w>n", cmd = "<C-w>j",                   opts = { desc = "Down Window" } },
  { keys = "<C-w>e", cmd = "<C-w>k",                   opts = { desc = "Up Window" } },
  { keys = "<C-w>i", cmd = "<C-w>l",                   opts = { desc = "Right Window" } },
  { keys = "<A-x>",  cmd = "<Cmd>FzfLua commands<CR>", opts = { desc = "Commands" } },
}

return keymaps_modifier
