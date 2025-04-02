return {
  { import = "plugins.mod.blink-cmp" },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lsp-snippets" })
    end,
  },
}
