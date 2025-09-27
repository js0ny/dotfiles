-- This won't be loaded
-- I keep this since render-markdown sometimes buggy
return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      checkboxes = require("markview-presets").checkboxes.nerd,
      headings = {
        enable = true,
        shift_width = 1,
        heading_1 = {
          style = "label",
          hl = "MarkviewH1",
        },
      },
      code_blocks = {
        style = "language",
        language_direction = "right",
        hl = "MarkviewCode",
        info_hl = "MarkviewCodeInfo",
      },
    },
  },
}
