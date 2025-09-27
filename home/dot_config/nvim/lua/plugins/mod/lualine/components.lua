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

M.mode = {
  function()
    return ""
  end,
  -- color = mode_color_bg,
}

M.git = {
  "branch",
  icon = icons.git.Branch,
  color = { fg = colors.scheme.violet, gui = "bold" },
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
  color = { fg = colors.scheme.yellow, gui = "italic" },
}

M.filetype = {
  function()
    return vim.bo.filetype
  end,
  color = { fg = colors.scheme.blue, gui = "bold" },
}

M.eol = {
  function()
    return vim.bo.eol == true and icons.eol or ""
  end,
  color = { fg = colors.scheme.red },
}

M.command = {
  "command",
  color = { fg = colors.scheme.green, gui = "bold" },
}

M.encoding = {
  "o:encoding",
  color = { fg = colors.scheme.green, gui = "bold" },
}

M.indent = {
  function()
    local shiftwidth = vim.api.nvim_get_option_value("shiftwidth", { buf = 0 })
    return icons.indent .. " " .. shiftwidth
  end,
  padding = 1,
}

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
    added = { fg = colors.scheme.green },
    modified = { fg = colors.scheme.yellow },
    removed = { fg = colors.scheme.red },
  },
  cond = nil,
}

M.progress = {
  "progress",
}

-- TODO: Implement orgmode
M.orgmode = {
  function()
    return _G.orgmode.statusline()
  end,
}

-- local conditions = {
--   buffer_not_empty = function()
--     return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
--   end,
--   hide_in_width = function()
--     return vim.fn.winwidth(0) > 80
--   end,
--   check_git_workspace = function()
--     local filepath = vim.fn.expand("%:p:h")
--     local gitdir = vim.fn.finddir(".git", filepath .. ";")
--     return gitdir and #gitdir > 0 and #gitdir < #filepath
--   end,
-- }
-- local mode_color = colors.mode
--
-- local mode_color_bg = function()
--   return { fg = colors.mantle, bg = mode_color[vim.fn.mode()] }
-- end

return M
