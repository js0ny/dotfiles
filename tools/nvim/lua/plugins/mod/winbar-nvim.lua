return {
  {
    "fgheng/winbar.nvim",
    config = function()
      require("winbar").setup({
        enabled = true,
        show_file_path = true,
        show_symbols = true,
        colors = {
          path = "",
          file_name = "",
          symbols = "",
        },
        icons = {
          file_icon_default = "",
          seperator = ">",
          editor_state = "●",
          lock_icon = "",
        },
        exclude_filetype = {
          "help",
          "startify",
          "dashboard",
          "packer",
          "neogitstatus",
          "NvimTree",
          "Trouble",
          "alpha",
          "lir",
          "Outline",
          "spectre_panel",
          "toggleterm",
          "qf",
          "floaterm",
          "orgagenda",
          "grug-far"
        },
      })
    end,
  },
}
