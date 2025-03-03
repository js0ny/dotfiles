return {
  { "wakatime/vim-wakatime",               lazy = false },
  {
    "voldikss/vim-floaterm",
    keys = {
      { "<leader>!",  ":FloatermToggle<CR>", desc = "Toggle Terminal" },
      { "<leader>tt", ":FloatermToggle<CR>", desc = "Toggle Terminal" },
      { "<leader>fT", ":FloatermNew<CR>",    desc = "Spawn a float terminal" },
    },
    cmd = {
      "FloatermToggle",
      "FloatermNew",
    },
  },
  {
    "CRAG666/code_runner.nvim",
    config = true,
    keys = {
      { "<leader>cr", ":RunCode<CR>", desc = "Run code" },
    },
    dependencies = {

      {
        "CRAG666/betterTerm.nvim",
        opts = {
          position = "bot",
          size = 15,
        },
      },
    },
  },
  { import = "plugins.mod.obsidian-nvim" },
  { import = "plugins.mod.which-keys-nvim" },
  { import = "plugins.mod.copilot-lua" },
  { import = "plugins.mod.avante-nvim" },
  {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- "ibhagwan/fzf-lua",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      -- configuration goes here
    },
  },
  { import = "plugins.mod.image-nvim" },
  --   "3rd/image.nvim",
  --   opts = {},
  -- },
}
