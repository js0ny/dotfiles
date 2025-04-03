-- Welcome to nvim's systemd :D

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { key = "p", icon = "󰈞 ", desc = "查找项目", action = "<cmd>Telescope projects<CR>" },
          { key = "h", icon = " ", desc = "历史文件", action = "<cmd>Telescope oldfiles<CR>" },
          { key = "l", icon = " ", desc = "加载会话", action = "<cmd>SessionSearch<CR>" },
          {
            key = "c",
            icon = " ",
            desc = "转到设置",
            action = "<cmd>Telescope find_files cwd=~/.config/nvim<CR>",
          },
          { key = "q", icon = "󱊷 ", desc = "退出", action = "<cmd>qa<CR>" },
        },
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    -- explorer = {
    --   -- TODO: Remap some keys in explorer
    --   -- win = {
    --   --   list = {
    --   --     keys = {
    --   --       ["l"] = "focus_input",
    --   --       ["i"] = "confirm",
    --   --       ["O"] = "explorer_open", -- Open with system default
    --   --     },
    --   --   },
    --   -- },
    -- },
    indent = { enabled = true },
    -- input = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scope = { enabled = true },
    -- scroll = { enabled = true },
    statuscolumn = { enabled = true },
    -- words = { enabled = true },
    image = { enabled = true },
  },
  keys = {
    -- {
    --   "<leader>ft",
    --   function()
    --     require("snacks").explorer()
    --   end,
    --   desc = "Toggle File Explorer",
    -- },
  },
}
