return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  enabled = vim.g.ai_enabled,
  opts = {
    suggestion = {
      auto_trigger = true,
      -- hide_during_completion = vim.g.ai_cmp,
      keymap = {
        accept = "<M-l>", -- Inspired from zed
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    -- Disable <M-CR> to open Copilot panel
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
      beancount = false,
      yaml = false,
    },
  },
}
