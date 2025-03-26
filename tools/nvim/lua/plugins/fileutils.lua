return {
  {
    "rmagatti/auto-session",
    event = "BufReadPre",

    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    },
  },
  -- { import = "plugins.mod.nvim-tree" },
  { import = "plugins.mod.telescope" },
  -- { import = "plugins.mod.fzf" },
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "Makefile", "package.json" },
      sync_root_with_cwd = true,
      silent_chdir = true,
      scope_chdir = "global",
    },
    config = function()
      require("telescope").load_extension("projects")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  -- {
  --   "kdheepak/lazygit.nvim",
  --   lazy = true,
  --   cmd = {
  --     "LazyGit",
  --     "LazyGitConfig",
  --     "LazyGitCurrentFile",
  --     "LazyGitFilter",
  --     "LazyGitFilterCurrentFile",
  --   },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   -- setting the keybinding for LazyGit with 'keys' is recommended in
  --   -- order to load the plugin when the command is run for the first time
  --   keys = {
  --     { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --   },
  -- },
  {
    "NeogitOrg/neogit",
    -- dependencies = {
    --   "nvim-lua/plenary.nvim", -- required
    --   "nvim-telescope/telescope.nvim", -- optional
    -- },
    config = true,
    -- event = "VeryLazy",
    cmd = {
      "Neogit",
    },
  },
}
