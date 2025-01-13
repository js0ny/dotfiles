return {
  { "wakatime/vim-wakatime", lazy = false },
  { "voldikss/vim-floaterm" },
  { "CRAG666/betterTerm.nvim", opts = {
    position = "bot",
    size = 15,
  } },
  { "CRAG666/code_runner.nvim", config = true },
  { import = "plugins.mod.obsidian-nvim" },
  {

    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "github/copilot.vim",
    lazy = false,
  },
}
