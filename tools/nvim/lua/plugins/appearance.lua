return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "RRethy/vim-illuminate" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.mod.lualine")
    end,
  },
  {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup({
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 500,
        },
      })
    end,
  },
  { import = "plugins.mod.alpha-nvim" },
  { import = "plugins.mod.winbar-nvim" },
  { import = "plugins.mod.bufferline" },
}
