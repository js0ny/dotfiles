-- stylua: ignore start
local M = {
  { keys = "gd",        cmd = vim.lsp.buf.definition,     opts = { desc = "Goto Definition" } },
  { keys = "<C-CR>",    cmd = vim.lsp.buf.definition,     opts = { desc = "Goto Definition" } },
  { keys = "gD",        cmd = vim.lsp.buf.declaration,    opts = { desc = "Goto Declaration" } },
  { keys = "gr",        cmd = vim.lsp.buf.references,     opts = { desc = "Goto References" } },
  { keys = "gi",        cmd = vim.lsp.buf.implementation, opts = { desc = "Goto Implementation" } },
  { keys = "<leader>,", cmd = vim.lsp.buf.code_action,    opts = { desc = "Code Action" } },
  { keys = "ga",        cmd = vim.lsp.buf.code_action,    opts = { desc = "Code Action" } },
  { keys = "gh",        cmd = vim.lsp.buf.hover,          opts = { desc = "Show hover" } },
  -- [c]hange [d]efinition
  { keys = "cd",        cmd = vim.lsp.buf.rename,         opts = { desc = "Rename symbol under cursor" } },
}
-- stylua: ignore end

local function smart_split(func)
  local width = vim.api.nvim_win_get_width(0)
  if width > 80 then
    vim.api.nvim_command("vsp")
  else
    vim.api.nvim_command("sp")
  end
  func()
end

vim.keymap.set("n", "<C-w>d", function()
  smart_split(vim.lsp.buf.definition)
end, { desc = "Go to Definition (Smart Split)" })

vim.keymap.set("n", "<C-w>D", function()
  smart_split(vim.lsp.buf.declaration)
end, { desc = "Go to Declaration (Smart Split)" })

return M
