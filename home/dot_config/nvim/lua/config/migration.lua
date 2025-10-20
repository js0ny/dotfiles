local nvim_version = vim.version()


if nvim_version.minor ~= 11 then
  return
end


vim.diagnostic.config({
  virtual_lines = true,
})

-- vim.lsp.enable({
--   "clangd",
--   "luals",
-- })

local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file('lsp/*', true)) do
    local name = vim.fn.fnamemodify(v, ':t:r')
    lsp_configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(lsp_configs))

-- Delete 0.11 new gr- keymaps
vim.keymap.del({ "n" }, "grn")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del({ "n" }, "gri")


