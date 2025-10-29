local dsigns = require("config.icons").diagnostics

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  severity_sort = true,
  update_in_insert = true,
  float = true,
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = dsigns.Hint,
      [vim.diagnostic.severity.WARN] = dsigns.Warning,
      [vim.diagnostic.severity.ERROR] = dsigns.Error,
    },
  },
})
