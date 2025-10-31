return {
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
  -- { import = "plugins.mod.nvim-tree" },
  -- { import = "plugins.mod.telescope" },
  { import = "plugins.mod.fzf" },
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
  -- {
  --   "NeogitOrg/neogit",
  --   config = true,
  --   cmd = {
  --     "Neogit",
  --   },
  -- },
  { import = "plugins.mod.neo-tree" },
}
