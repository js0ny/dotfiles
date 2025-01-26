local lualine = require("lualine")

-- Color table for highlights

local colors = require("plugins.mod.lualine.colors")
local components = require("plugins.mod.lualine.components")

-- Config
local config = {
  options = {
    disabled_filetypes = {
      statusline = { "NvimTree", "alpha" },
    },
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
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

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

--[[
VSCode Style:
Remote | Git Branch | Diagnostics | Command | | MID | | Line:Column | Indent | Encoding | EOL | File Type LSP | Notifications
--]]

ins_left(components.mode)
ins_left(components.diff)
ins_left(components.git)
ins_left(components.diagnostics)
ins_left(components.command)
ins_right(components.indent)
ins_right(components.encoding)
ins_right(components.eol)
ins_right(components.filetype)
ins_right(components.lsp)
ins_right(components.progress)

lualine.setup(config)
