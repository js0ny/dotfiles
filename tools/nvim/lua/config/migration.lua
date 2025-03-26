local nvim_version = vim.version()

if nvim_version.minor ~= 11 then
  return
end

vim.diagnostic.config({
  virtual_lines = true,
})

vim.lsp.enable({
  "clangd",
  "luals",
})
