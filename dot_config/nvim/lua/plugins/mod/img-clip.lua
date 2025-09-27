return {
  {
    -- support for image pasting
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    ft = { "avante", "markdown", "typst", "org", "tex" },
    cmd = "PasteImage",
    keys = {
      {
        "<localleader>p",
        function()
          require("img-clip").paste_image()
        end,
        desc = "Paste Image",
      }
    },
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
      },
    }
  }
}
