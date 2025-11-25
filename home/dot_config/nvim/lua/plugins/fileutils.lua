return {
  -- Picker
  { import = "plugins.mod.fzf" },
  -- Explorer
  -- { import = "plugins.mod.neo-tree" },
  {
    "rmagatti/auto-session",
    event = "BufReadPre",
    cmd = {
      "AutoSession",
    },
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
    keys = {
      { "<leader>ps", "<Cmd>AutoSession search<CR>", desc = "List all sessions" },
    },
  },
  -- {
  --   "ahmedkhalf/project.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     detection_methods = { "lsp", "pattern" },
  --     patterns = { ".git", "Makefile", "package.json" },
  --     sync_root_with_cwd = true,
  --     silent_chdir = true,
  --     scope_chdir = "global",
  --   },
  --   config = function()
  --     require("telescope").load_extension("projects")
  --   end,
  --   dependencies = { "nvim-telescope/telescope.nvim" },
  -- },
  {
    "NeogitOrg/neogit",
    config = true,
    dependencies = {
      "sindrets/diffview.nvim",
    },
    cmd = {
      "Neogit",
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
      default_file_explorer = true,
    },
    -- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
