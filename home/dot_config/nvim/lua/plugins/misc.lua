return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "wakatime/vim-wakatime", lazy = false },
  { import = "plugins.mod.toggleterm" },
  { import = "plugins.mod.which-keys-nvim" },
  -- { import = "plugins.mod.copilot-lua" },
  -- { import = "plugins.mod.avante-nvim" },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    cmd = {
      "Leet",
    },
    lazy = true,
    -- event = "VeryLazy",
    dependencies = {
      -- "nvim-telescope/telescope.nvim",
      "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
  -- { import = "plugins.mod.image-nvim" },
  { import = "plugins.mod.snacks-nvim" },
}
