require("plugins.lazy-nvim")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins.appearance" },
    { import = "plugins.completion" },
    { import = "plugins.fileutils" },
    { import = "plugins.lsp" },
    { import = "plugins.dap" },
    { import = "plugins.edit" },
    { import = "plugins.misc" },
  },
  checker = { enabled = false },
})
