return {
  { "catppuccin/nvim", name = "catppuccin" },
  { "olimorris/onedarkpro.nvim" },
  { "rebelot/kanagawa.nvim" },
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
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
