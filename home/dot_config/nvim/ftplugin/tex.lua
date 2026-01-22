local bufmap = {
  { mode = "x", keys = "<leader>i", cmd = 'c\\textit{<C-r>"}', opt = { desc = "Add italic to selected text" } },
  { mode = "x", keys = "<leader>b", cmd = 'c\\textbf{<C-r>"}', opt = { desc = "Add bold to selected text" } },
  {
    mode = "x",
    keys = "<leader>c",
    cmd = 'c\\begin{verbatim}<CR><C-r>"<CR>\\end{verbatim}',
    opt = { desc = "Add code block to selected text" },
  },
  { mode = "x", keys = "<leader>d", cmd = 'c\\sout{<C-r>"}', opt = { desc = "Add strikethrough to selected text" } },
  { mode = "x", keys = "<leader>h", cmd = 'c\\hl{<C-r>"}', opt = { desc = "Add highlight to selected text" } },
  -- { mode = "n", keys = "<leader>cc", cmd = "<cmd>w<CR>", opt = { desc = "Save and compile tex file" } },
}

local set_buf_keymaps = require("keymaps.utils").set_buf_keymaps

set_buf_keymaps(bufmap)
