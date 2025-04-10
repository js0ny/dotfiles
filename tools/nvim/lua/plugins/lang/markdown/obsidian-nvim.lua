return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- lazy = false,
  ft = "markdown",

  cmd = {
    "ObsidianNewFromTemplate",
    "ObsidianToggleCheckbox",
    "ObsidianQuickSwitch",
    "ObsidianExtractNote",
    "ObsidianFollowLink",
    "ObsidianBacklinks",
    "ObsidianWorkspace",
    "ObsidianYesterday",
    "ObsidianPasteImg",
    "ObsidianTomorrow",
    "ObsidianTemplate",
    "ObsidianDailies",
    "ObsidianLinkNew",
    "ObsidianRename",
    "ObsidianSearch",
    "ObsidianCheck",
    "ObsidianLinks",
    "ObsidianToday",
    "ObsidianDebug",
    "ObsidianOpen",
    "ObsidianTags",
    "ObsidianLink",
    "ObsidianNew",
    "ObsidianTOC",
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  keys = {
    { "<leader>fo", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian: Quick Switch" },
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
    "ibhagwan/fzf-lua",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Obsidian",
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
    ui = {
      enable = false,
    },
    daily_notes = {
      folder = "_Global/Periodic",
      date_format = "%Y-%m-%d",
      default_tags = { "daily" },
      template = nil,
    },
    -- see below for full list of options 👇
    attachments = {
      img_folder = "_Global/Assets",
      img_name_func = function()
        return string.format("%s-", os.time())
      end,
    },
    mappings = {
      ["<cr>"] = {
        action = function()
          require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    new_notes_location = "current_dir",
  },
}
