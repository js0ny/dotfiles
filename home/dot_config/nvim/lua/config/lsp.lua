-- Source all lsp definition in
-- ~/.config/nvim/lsp/*.lua
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  lsp_configs[name] = true
end
vim.lsp.enable(vim.tbl_keys(lsp_configs))
