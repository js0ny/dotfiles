local mode_arrow = { "n", "v", "o", "s", "x" }

local keymaps_basic = { -- Modification of Original Keymap - Colemak
  -- https://github.com/LazyVim/LazyVim/blob/d1529f650fdd89cb620258bdeca5ed7b558420c7/lua/lazyvim/config/keymaps.lua#L8
  {
    mode = mode_arrow,
    keys = "n",
    cmd = "v:count == 0 ? 'gj' : 'j'",
    opts = { desc = "Down", expr = true, silent = true },
  },
  {
    mode = mode_arrow,
    keys = "<Down>",
    cmd = "v:count == 0 ? 'gj' : 'j'",
    opts = { desc = "Up", expr = true, silent = true },
  },
  {
    mode = mode_arrow,
    keys = "e",
    cmd = "v:count == 0 ? 'gk' : 'k'",
    opts = { desc = "Up", expr = true, silent = true },
  },
  {
    mode = mode_arrow,
    keys = "<Up>",
    cmd = "v:count == 0 ? 'gk' : 'k'",
    opts = { desc = "Up", expr = true, silent = true },
  },
  { mode = mode_arrow, keys = "h", cmd = "h", opts = { desc = "Left", silent = true } },
  { mode = mode_arrow, keys = "i", cmd = "l", opts = { desc = "Right", silent = true } },
  { keys = "H", cmd = ":bprevious<CR>" },
  { keys = "N", cmd = "5j" },
  { keys = "E", cmd = "5k" },
  { keys = "I", cmd = ":bnext<CR>" },
  -- Text object implementation
  { mode = { "n", "o", "x" }, keys = "l", cmd = "i", opts = { desc = "inside" } },
  { keys = "L", cmd = "I" },
  { keys = "k", cmd = "n" },
  { keys = "K", cmd = "N" },
  { keys = "j", cmd = "e" },
  { keys = "J", cmd = "E" },
  { keys = "Y", cmd = "y$" },
  -- https://github.com/LazyVim/LazyVim/blob/d1529f650fdd89cb620258bdeca5ed7b558420c7/lua/lazyvim/config/keymaps.lua#L60
  { keys = "<Esc>", cmd = "<Cmd>nohlsearch<Bar>diffupdate<CR>" },
}

return keymaps_basic
