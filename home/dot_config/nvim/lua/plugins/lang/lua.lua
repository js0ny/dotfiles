return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  enabled = function(root_dir)
    return vim.g.lazydev_enabled == nil and true or vim.g.lazy
  end,
}
