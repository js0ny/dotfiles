return {
  { "catppuccin/nvim", name = "catppuccin" },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("plugins.mod.lualine")
    end,
  },
  { import = "plugins.mod.alpha-nvim" },
}

