local lualine = require("lualine")

-- Color table for highlights

-- local colors = require("config.colors")
local components = require("plugins.mod.lualine.components")

--[[
VSCode Style:
Remote | Git Branch | Diagnostics | Command | | MID | | Line:Column | Indent | Encoding | EOL | File Type LSP | Notifications
--]]

-- Config
local config = {
  options = {
    disabled_filetypes = {
      statusline = { "NvimTree", "alpha", "grug-far", "snacks_dashboard" },
    },
    -- Disable sections and component separators
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- theme = "catppuccin",
    theme = "auto",
    -- IDE-like Global Status
    globalstaus = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.diff,
    },
    lualine_c = {
      components.diagnostics,
    },
    lualine_x = {
      components.orgmode,
      components.indent,
      components.encoding,
      components.eol,
    },
    lualine_y = {
      components.filetype,
      components.lsp,
    },
    lualine_z = {
      components.progress,
    },
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

lualine.setup(config)
