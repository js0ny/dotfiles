-- This file *currently* contains the colorscheme for lualine (status line)

local M = {}
-- Mocha
M.scheme = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#cdd6f4",
  subtext1 = "#bac2de",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
  surface2 = "#585b70",
  surface1 = "#45475a",
  surface0 = "#313244",
  base = "#1e1e2e",
  mantle = "#181825",
  crust = "#11111b",
}
M.accent = M.scheme.pink

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
