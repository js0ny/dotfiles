return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        entry_prefix = " ",
        layout_config = { -- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/configs/telescope.lua
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
        },
        mappings = {
          n = {
            ["n"] = "move_selection_next",
            ["e"] = "move_selection_previous",
            ["w"] = "preview_scrolling_up",
            ["r"] = "preview_scrolling_down",
            ["a"] = "preview_scrolling_left",
            ["s"] = "preview_scrolling_right",
            ["q"] = require("telescope.actions").close,
          },
        },
      },
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
