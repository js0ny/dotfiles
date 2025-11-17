vim.keymap.set("n", "<leader>mx", '<cmd>!chmod +x "%"<CR>', {
  desc = "Mark the file as executable",
  buffer = true
})
vim.keymap.set("i", "<C-m>x", '<cmd>!chmod +x "%"<CR>', {
  desc = "Mark the file as executable",
  buffer = true
})
vim.keymap.set("n", "<leader>mX", '<cmd>!chmod u+x "%"<CR>', {
  desc = "Mark the file as executable (current user only)",
  buffer = true
})
vim.keymap.set("i", "<C-m>X", '<cmd>!chmod u+x "%"<CR>', {
  desc = "Mark the file as executable (current user only)",
  buffer = true
})
