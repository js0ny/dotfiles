local M = {
  { keys = "gd", cmd = vim.lsp.buf.definition, opts = { desc = "Goto Definition" } },
  { keys = "<C-CR>", cmd = vim.lsp.buf.definition, opts = { desc = "Goto Definition" } },
  { keys = "gD", cmd = vim.lsp.buf.declaration, opts = { desc = "Goto Declaration" } },
  { keys = "gr", cmd = vim.lsp.buf.references, opts = { desc = "Goto References" } },
  { keys = "gi", cmd = vim.lsp.buf.implementation, opts = { desc = "Goto Implementation" } },
  { keys = "<leader>,", cmd = vim.lsp.buf.code_action, opts = { desc = "Code Action" } },
  { keys = "ga", cmd = vim.lsp.buf.code_action, opts = { desc = "Code Action" } },
  { keys = "gh", cmd = vim.lsp.buf.hover, opts = { desc = "Show hover" } },
}

return M
