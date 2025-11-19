return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "BufReadPost",
  opts = {
    suggestion = {
      enabled = not vim.g.ai_cmp,
      auto_trigger = true,
      hide_during_completion = vim.g.ai_cmp,
      keymap = {
        accept = "<M-l>", -- Inspired from zed
        next = "<M-]>",
        prev = "<M-[>",
      },
    },
    panel = { enabled = true },
    filetypes = {
      markdown = true,
      help = true,
      beancount = false,
      yaml = false,
    },
  },
}
