local mode_arrow = { "n", "v", "o", "s", "x" }

local keymaps_basic = { -- Modification of Original Keymap - Colemak
  { mode = mode_arrow, keys = "n", cmd = "j", desc = "Down" },
  { mode = mode_arrow, keys = "e", cmd = "k", desc = "Up" },
  { mode = mode_arrow, keys = "i", cmd = "l", desc = "Right" },
  { keys = "H", cmd = ":bprevious<CR>" },
  { keys = "N", cmd = "5j" },
  { keys = "E", cmd = "5k" },
  { keys = "I", cmd = ":bnext<CR>" },
  -- Text object implementation
  { mode = { "n", "o", "x" }, keys = "l", cmd = "i", group = "inside" },
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
