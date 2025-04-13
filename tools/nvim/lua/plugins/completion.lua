return {
  { import = "plugins.mod.blink-cmp" },
  -- { import = "plugins.mod.nvim-cmp" },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/lsp-snippets" })
      require("luasnip").setup({
        history = true,
        enable_autosnippets = true,
      })
    end,
  },
  {
    "js0ny/luasnip-latex-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    ft = { "tex", "latex", "markdown", "org" },
    opts = {}
  }
}
