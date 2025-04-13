local uuid = function()
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function(c)
    local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
    return string.format('%x', v)
  end)
end


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
    templates = {
      folder = "_Global/LuaTemplates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        uuid = uuid()
      },
    },
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      -- Force to use UUID as the note id.
      local note_id
      if note.metadata then
        note_id = note.id
      else
        note_id = uuid()
      end

      local out = {
        id = note_id,
        aliases = note.aliases,
        tags = note.tags,
        title = note.id,
        date = os.date(
          "%Y-%m-%dT00:00:00"),
      }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      -- Force to update mtime.
      out.mtime = os.date("%Y-%m-%dT%H:%M:%S")
      return out
    end,
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
