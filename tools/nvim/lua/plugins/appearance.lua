-- https://stackoverflow.com/a/73365602
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
})

return {
  -- Colorschemes
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavor = "auto",
      background = {
        light = "latte",
        dark = "mocha",
      },
      integrations = {
        -- lualine = true,
        "lualine",
        "blink_cmp"
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "dawn",
    },
    cmd = "FzfLua colorschemes",
  },
  { "rebelot/kanagawa.nvim",          cmd = "FzfLua colorschemes" },
  { -- Modern Status Line
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("plugins.mod.lualine")
    end,
  },
  -- { -- Breadcrumb
  --   "Bekaboo/dropbar.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --   },
  --   opts = {},
  --   keys = {
  --     {
  --       "<Leader>+",
  --       function()
  --         require("dropbar.api").pick()
  --       end,
  --       desc = "Pick symbols in winbar",
  --     },
  --     {
  --       "[;",
  --       function()
  --         require("dropbar.api").goto_context_start()
  --       end,
  --       desc = "Go to start of current context",
  --     },
  --     {
  --       "];",
  --       function()
  --         require("dropbar.api").select_next_context()
  --       end,
  --       desc = "Select next context",
  --     },
  --   },
  -- },
  { import = "plugins.mod.bufferline" }, -- Buffer Top Bar
  {                                      -- Git Blames, Changes
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
    event = "BufReadPre",
    keys = {
      { "<leader>gb", "<cmd>Gitsigns blame<CR>",                     desc = "Blame file" },
      { "<leader>gd", "<cmd>Gitsigns diffthis<CR>",                  desc = "Diff file" },
      { "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
    },
  },
  -- { -- Highlight and navigate between TODOs
  --   "folke/todo-comments.nvim",
  --   cmd = { "TodoTelescope" },
  --   event = "BufRead",
  --   opts = {},
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
}
