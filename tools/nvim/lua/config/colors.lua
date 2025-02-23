-- This file *currently* contains the colorscheme for lualine (status line)

local M = {}
-- TODO: Change the palatte when the colorscheme changes
M.scheme = require("catppuccin.palettes.mocha")

M.accent = M.scheme.lavender

M.mode = {
  n = M.scheme.sky,
  i = M.scheme.green,
  v = M.scheme.mauve,
  [""] = M.scheme.mauve,
  V = M.scheme.mauve,
  c = M.scheme.mauve,
  no = M.scheme.red,
  s = M.scheme.orange,
  S = M.scheme.orange,
  [""] = M.scheme.orange,
  ic = M.scheme.yellow,
  R = M.scheme.violet,
  Rv = M.scheme.violet,
  cv = M.scheme.red,
  ce = M.scheme.red,
  r = M.scheme.cyan,
  rm = M.scheme.cyan,
  ["r?"] = M.scheme.cyan,
  ["!"] = M.scheme.red,
  t = M.scheme.red,
}

return M
