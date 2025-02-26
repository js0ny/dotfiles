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
      integrations = {
        "lualine",
      },
    },
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
    opts = {
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 500,
      },
    },
  },
  { import = "plugins.mod.alpha-nvim" }, -- Dashboard
  { -- Breadcrumb
    "Bekaboo/dropbar.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {},
    keys = {
      {
        "<Leader>+",
        function()
          require("dropbar.api").pick()
        end,
        desc = "Pick symbols in winbar",
      },
      {
        "[;",
        function()
          require("dropbar.api").goto_context_start()
        end,
        desc = "Go to start of current context",
      },
      {
        "];",
        function()
          require("dropbar.api").select_next_context()
        end,
        desc = "Select next context",
      },
    },
  },
  { import = "plugins.mod.bufferline" }, -- Buffer Top Bar
  { -- Git Blames, Changes
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
    keys = {
      { "<leader>gb", ":Gitsigns blame<CR>", desc = "Blame file" },
      { "<leader>gd", ":Gitsigns diffthis<CR>", desc = "Diff file" },
      { "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
    },
  },
  { -- Highlight and navigate between TODOs
    "folke/todo-comments.nvim",
    opts = {},
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
