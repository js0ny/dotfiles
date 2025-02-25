return {
  -- Colorschemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      floavor = "auto",
      background = {
        light = "latte",
        dark = "mocha",
      },
      styles = {
        -- keywords = { "underline" },
      },
      integrations = {
        "lualine",
      },
    }
  },

  { "olimorris/onedarkpro.nvim" },
  { "rebelot/kanagawa.nvim" },
  -- Highlight objects under the cursor
  { "RRethy/vim-illuminate" },
  { -- Modern Status Line
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.mod.lualine")
    end,
  },
  { -- Highlight yanked text
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
  { import = "plugins.mod.alpha-nvim" },  -- Dashboard
  { import = "plugins.mod.winbar-nvim" }, -- Breadcrumb
  { import = "plugins.mod.bufferline" },  -- Buffer Top Bar
  {                                       -- Git Blames, Changes
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
      })
    end,
  },
  { -- Highlight and navigate between TODOs
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
