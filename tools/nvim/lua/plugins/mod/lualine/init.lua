local lualine = require("lualine")

-- Color table for highlights

local colors = require("config.colors")
local components = require("plugins.mod.lualine.components")

--[[
VSCode Style:
Remote | Git Branch | Diagnostics | Command | | MID | | Line:Column | Indent | Encoding | EOL | File Type LSP | Notifications
--]]

-- Config
local config = {
  options = {
    disabled_filetypes = {
      statusline = { "NvimTree", "alpha", "grug-far" },
    },
    -- Disable sections and component separators
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      -- normal = { c = { fg = colors.mantle, bg = colors.mantle } },
      -- visual = { c = { fg = colors.mantle, bg = colors.mauve } },
      -- normal = { c = { fg = colors.mantle, bg = colors.sapphire } },
      inactive = { c = { fg = colors.mantle, bg = colors.mantle } },
      normal = {
        a = {
          fg = colors.scheme.mantle,
          bg = colors.mode.n,
        },
        b = {
          bg = colors.scheme.surface2,
        },
        c = {
          bg = colors.scheme.crust,
        },
      },
      visual = {
        a = {
          fg = colors.scheme.mantle,
          bg = colors.mode.v,
        },
      },
      insert = {
        a = {
          fg = colors.scheme.mantle,
          bg = colors.mode.i,
        },
      },
    },
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
