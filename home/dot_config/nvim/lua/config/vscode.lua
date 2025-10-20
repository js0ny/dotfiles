require("plugins.lazy-nvim")

require("lazy").setup({
  spec = {
    -- import your plugins
    -- { import = "plugins.completion" },
    -- { import = "plugins.fileutils" },
    -- { import = "plugins.lsp" },
    -- { import = "plugins.edit" },
    -- { import = "plugins.misc" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- automatically check for plugin updates
  checker = { enabled = true },
})
