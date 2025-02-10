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
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = "<M-f>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
}
