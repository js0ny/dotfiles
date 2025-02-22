return {
  { "wakatime/vim-wakatime", lazy = false },
  { "voldikss/vim-floaterm" },
  {
    "CRAG666/betterTerm.nvim",
    opts = {
      position = "bot",
      size = 15,
    }
  },
  { "CRAG666/code_runner.nvim",            config = true },
  -- { import = "plugins.mod.obsidian-nvim" },
  { import = "plugins.mod.which-keys-nvim" },
  { import = "plugins.mod.copilot-lua" },
  { import = "plugins.mod.avante-nvim" }
}
