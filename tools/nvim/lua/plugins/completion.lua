return {
  -- { import = "plugins.mod.nvim-cmp" },
  -- {
  --   "saadparwaiz1/cmp_luasnip",
  -- },
  { import = "plugins.mod.blink-cmp" },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lsp-snippets" })
      -- require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
    -- config = function()
    --   require("copilot_cmp").setup()
    -- end,
  },
}
