return {
  { import = "plugins.mod.nvim-cmp" },
  {
    "saadparwaiz1/cmp_luasnip"
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_vscode").load_standalone(
        {
          path = "~/.config/zed/snippets/c.json" }
      )
    end,
    -- TODO: Remove this, simply delete this will let nvim-cmp not work
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
