
return {
  { import = "plugins.mod.lspconfig" },
  { "MeanderingProgrammer/render-markdown.nvim" },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,      -- Recommended
  --   -- ft = "markdown" -- If you decide to lazy-load anyway
  --
  --   dependencies = {
  --       "nvim-treesitter/nvim-treesitter",
  --       "nvim-tree/nvim-web-devicons"
  --   }
  -- },
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local servers = require("config.servers").servers

      mason_lspconfig.setup({
        ensure_installed = servers,
      })
    end
  },
}
