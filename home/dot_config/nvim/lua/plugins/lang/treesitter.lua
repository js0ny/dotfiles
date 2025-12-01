return {
  { "nvim-treesitter/nvim-treesitter-context", lazy = true },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    cmd = {
      "TSInstall",
      "TSUpdate",
      "TSUpdateSync",
    },
    event = {
      "BufReadPre",
    },
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
