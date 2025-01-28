-- Note that this plugin is a fork for colemak
-- Use mouse to select multiple cursors
vim.g.VM_mouse_mappings = 1
-- Disable default mappings
vim.g.VM_default_mappings = 0
vim.g.VM_custom_motions = {
  -- https://github.com/mg979/vim-visual-multi/issues/93
  h = "h",
  n = "j",
  e = "k",
  i = "l",
  j = "e",
}

vim.g.VM_maps = {
  ["Add Cursor Down"] = "<A-n>",
  ["Add Cursor Up"] = "<A-e>",
  ["i"] = "l",
  ["I"] = "L",
  ["n"] = "n",
}
