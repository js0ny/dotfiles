return {
  { import = "plugins.lang.org" },
  { import = "plugins.lang.markdown" },
  { import = "plugins.lang.just" },
  { import = "plugins.lang.typst" },
  { import = "plugins.lang.beancount" },
  { import = "plugins.lang.tex" },
  { import = "plugins.lang.lua" },
  { import = "plugins.lang.treesitter" },
  { import = "plugins.mod.trouble-nvim" },
  -- Remove mason and use system package manager
  -- {
  --   "williamboman/mason.nvim",
  --   cmd = "Mason",
  --   build = ":MasonUpdate",
  --   -- opts_extend = { "ensure_installed" },
  --   opts = {
  --     -- ensure_installed = require("config.servers").servers,
  --   },
  -- },
  { import = "plugins.mod.conform-nvim" },
}
