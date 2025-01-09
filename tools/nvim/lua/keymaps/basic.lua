local mode_arrow = { "n", "v", "o", "s", "x" }

local keymaps_basic = { -- Modification of Original Keymap - Colemak
  { mode = mode_arrow, keys = "n", cmd = "j" },
  { mode = mode_arrow, keys = "e", cmd = "k" },
  { mode = mode_arrow, keys = "i", cmd = "l" },
  { keys = "H", cmd = ":bprevious<CR>" },
  { keys = "N", cmd = "5j" },
  { keys = "E", cmd = "5k" },
  { keys = "I", cmd = ":bnext<CR>" },
  { keys = "l", cmd = "i" },
  { keys = "L", cmd = "I" },
  { keys = "k", cmd = "n" },
  { keys = "K", cmd = "N" },
  { keys = "j", cmd = "e" },
  { keys = "J", cmd = "E" },
  { keys = "Y", cmd = "y$" },
}

return keymaps_basic
