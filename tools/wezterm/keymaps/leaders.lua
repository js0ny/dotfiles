local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

-- #region Leader Keymaps
M.common = {
  {
    key = "q",
    mods = "LEADER",
    action = act.SendKey({ key = "q", mods = "CTRL" }),
  },
  -- Windows Management
  { -- leader keys
    key = "|",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "H",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "/",
    mods = "LEADER",
    action = act.Search({ Regex = "" }),
  },
  {
    key = "?",
    mods = "LEADER|SHIFT",
    action = act.Search({ CaseSensitiveString = "" }),
  },
  {
    key = ";",
    mods = "LEADER",
    action = act.ShowLauncher,
  },
  {
    key = ":",
    mods = "LEADER|SHIFT",
    action = act.ActivateCommandPalette,
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
      timeout_milliseconds = 2000,
    }),
  },
}
-- #endregion



return M
