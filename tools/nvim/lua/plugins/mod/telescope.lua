return {
  "nvim-telescope/telescope.nvim",
  config = function ()
    require("telescope").setup {
      defaults = {
        mappings = {
          n = {
            ["n"] = "move_selection_next",
            ["e"] = "move_selection_previous",
            ["w"] = "preview_scrolling_up",
            ["r"] = "preview_scrolling_down",
            ["a"] = "preview_scrolling_left",
            ["s"] = "preview_scrolling_right",
          }
        }
      }
    }
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}

