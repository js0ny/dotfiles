return {
  "lewis6991/hover.nvim",
  opts = {
    init = function()
      -- Require providers
      require("hover.providers.lsp")
      -- require('hover.providers.gh')
      -- require('hover.providers.gh_user')
      -- require('hover.providers.jira')
      -- require('hover.providers.dap')
      -- require('hover.providers.fold_preview')
      require("hover.providers.diagnostic")
      -- require('hover.providers.man')
      -- require('hover.providers.dictionary')
    end,
    preview_opts = {
      border = "single",
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true,
    mouse_providers = {
      "LSP",
    },
    mouse_delay = 1000,
  },
  keys = {
    {
      "gE",
      function()
        require("hover").hover_select()
      end,
      desc = "hover.nvim (select)",
    },
    {
      "<C-p>",
      function()
        require("hover").hover_switch("previous")
      end,
      desc = "hover.nvim (previous source)",
    },
    {
      "<C-n>",
      function()
        require("hover").hover_switch("next")
      end,
      desc = "hover.nvim (next source)",
    },
    {
      "<MouseMove>",
      function()
        require("hover").hover_mouse()
      end,
      desc = "hover.nvim (mouse)",
    },
  },
}
