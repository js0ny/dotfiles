
return {
  { import = "plugins.mod.lspconfig" },
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
      local servers = require("config.servers")

      mason_lspconfig.setup({
        ensure_installed = servers,
      })
    end
  },
}
