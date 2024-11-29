return {
  { import = "plugins.mod.nvim-treesitter", },
  { 'echasnovski/mini.pairs', version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
}

