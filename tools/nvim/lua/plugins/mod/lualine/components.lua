local M = {}
local colors = require("config.colors")
local icons = require("config.icons")

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local mode_color = {
  n = colors.blue,
  i = colors.green,
  v = colors.magenta,
  [""] = colors.magenta,
  V = colors.magenta,
  c = colors.magenta,
  no = colors.red,
  s = colors.orange,
  S = colors.orange,
  [""] = colors.orange,
  ic = colors.yellow,
  R = colors.violet,
  Rv = colors.violet,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ["r?"] = colors.cyan,
  ["!"] = colors.red,
  t = colors.red,
}

local mode_color_bg = function()
  return { fg = colors.bg, bg = mode_color[vim.fn.mode()] }
end

-- local mode_color_fg = function()
--   return { fg = mode_color[vim.fn.mode()] }
-- end

M.mode = {
  function()
    return ""
  end,
  color = mode_color_bg,
}

M.git = {
  "branch",
  icon = icons.git.Branch,
  color = { fg = colors.violet, gui = "bold" },
}

M.diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = icons.diagnostics.Error .. " ",
    warn = icons.diagnostics.Warning .. " ",
    info = icons.diagnostics.Information .. " ",
    hint = icons.diagnostics.Hint .. " ",
  },
}

M.lsp = {
  -- Lsp server name .
  function()
    local msg = "LSP Inactive"
    local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = icons.lsp,
  color = { fg = colors.yellow, gui = "italic" },
}

M.filetype = {
  function()
    return vim.bo.filetype
  end,
  color = { fg = colors.blue, gui = "bold" },
}

M.eol = {
  function()
    return vim.bo.eol == true and icons.eol or ""
  end,
  color = { fg = colors.red },
}

M.command = {
  "command",
  color = { fg = colors.green, gui = "bold" },
}

M.encoding = {
  "o:encoding",
  color = { fg = colors.green, gui = "bold" },
}

M.indent = {
  function()
    local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
    return icons.indent .. " " .. shiftwidth
  end,
  padding = 1,
}

-- M.diff = {
--   "diff",
--   -- Is it me or the symbol for modified us really weird
--   symbols = { added = " ", modified = "󰝤 ", removed = " " },
--   diff_color = {
--     added = { fg = colors.green },
--     modified = { fg = colors.orange },
--     removed = { fg = colors.red },
--   },
--   cond = conditions.hide_in_width,
-- }
M.diff = {
  "diff",
  source = diff_source,
  -- symbols = { added = " ", modified = "󰝤 ", removed = " " },
  symbols = {
    added = icons.git.Add .. " ",
    modified = icons.git.Change .. " ",
    removed = icons.git.Delete .. " ",
  },
  padding = { left = 2, right = 1 },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
  cond = nil,
}

M.progress = { "progress", color = mode_color_bg }

return M
