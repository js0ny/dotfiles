local mode_arrow = { "n", "v", "s", "x", "o" }

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
    opts = { desc = "Down", expr = true, silent = true },
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

  {
    mode = "o",
    keys = "n",
    cmd = "j",
    opts = { desc = "Down", silent = true },
  },
  {
    mode = "o",
    keys = "<Down>",
    cmd = "j",
    opts = { desc = "Down", silent = true },
  },
  {
    mode = "o",
    keys = "e",
    cmd = "k",
    opts = { desc = "Up", silent = true },
  },
  {
    mode = "o",
    keys = "<Up>",
    cmd = "k",
    opts = { desc = "Up", silent = true },
  },

  { mode = mode_arrow, keys = "h", cmd = "h", opts = { desc = "Left", silent = true } },
  { mode = mode_arrow, keys = "i", cmd = "l", opts = { desc = "Right", silent = true } },
  { mode = {"n"}, keys = "H", cmd = "<cmd>bprevious<CR>", opts = { desc = "Previous Buffer" } },
  { mode = {"n"}, keys = "I", cmd = "<cmd>bnext<CR>", opts = { desc = "Next Buffer" } },
  { mode = {"v", "o", "x"}, keys = "H", cmd = "^", opts = { desc = "Start of Line" } },
  { mode = {"v", "o", "x"}, keys = "I", cmd = "$", opts = { desc = "End of Line" } },
  { mode = mode_arrow, keys = "N", cmd = "5j", opts = { desc = "Up 5 Lines" } },
  { mode = mode_arrow, keys = "E", cmd = "5e", opts = { desc = "Down 5 Lines" } },
  { keys = "Y", cmd = "y$", opts = { desc = "Yank to End of Line" } },
  { mode = mode_arrow, keys = "N", cmd = "5j" },
  { mode = mode_arrow, keys = "E", cmd = "5k" },
  { mode = { "n", "o", "x" }, keys = "l", cmd = "i", opts = { desc = "Insert" } },
  { keys = "L", cmd = "I", opts = { desc = "Insert at Start of Line" } },
  { mode = mode_arrow, keys = "k", cmd = "n", opts = { desc = "Next Search" } },
  { mode = mode_arrow, keys = "K", cmd = "N", opts = { desc = "Previous Search" } },
  { mode = mode_arrow, keys = "j", cmd = "e", opts = { desc = "jump to end of word" } },
  { mode = mode_arrow, keys = "J", cmd = "E", opts = { desc = "jump to end of WORD" } },
  -- https://github.com/LazyVim/LazyVim/blob/d1529f650fdd89cb620258bdeca5ed7b558420c7/lua/lazyvim/config/keymaps.lua#L60
  { keys = "<Esc>", cmd = "<Cmd>nohlsearch<Bar>diffupdate<CR>", opts = { desc = "Clear Search Highlight" } },
}

return keymaps_basic
