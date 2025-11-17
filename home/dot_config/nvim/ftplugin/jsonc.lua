vim.keymap.set("n", "<leader>mp", '<cmd>!jq<CR>', {
  desc = "Pretiffy json",
  buffer = true
})
vim.keymap.set("i", "<C-m>p", '<cmd>%!jq<CR>', {
  desc = "Pretiffy json",
  buffer = true
})
