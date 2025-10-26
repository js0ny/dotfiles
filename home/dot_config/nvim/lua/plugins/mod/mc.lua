return {
  "brenton-leighton/multiple-cursors.nvim",
  version = "*", -- Use the latest tagged version
  -- opts = , -- This causes the plugin setup function to be called
  keys = {
    {
      "<A-j>",
      "<Cmd>MultipleCursorsAddDown<CR>",
      mode = { "n", "x" },
      desc = "Add cursor and move down",
    },
    {
      "<A-k>",
      "<Cmd>MultipleCursorsAddUp<CR>",
      mode = { "n", "x" },
      desc = "Add cursor and move up",
    },

    {
      "<C-Up>",
      "<Cmd>MultipleCursorsAddUp<CR>",
      mode = { "n", "i", "x" },
      desc = "Add cursor and move up",
    },
    {
      "<C-Down>",
      "<Cmd>MultipleCursorsAddDown<CR>",
      mode = { "n", "i", "x" },
      desc = "Add cursor and move down",
    },

    {
      "<A-LeftMouse>",
      "<Cmd>MultipleCursorsMouseAddDelete<CR>",
      mode = { "n", "i" },
      desc = "Add or remove cursor",
    },
  },
  config = function()
    require("multiple-cursors").setup({
      pre_hook = function()
        require("nvim-autopairs").disable()
      end,
      post_hook = function()
        require("nvim-autopairs").enable()
      end,
    })
  end,
}
