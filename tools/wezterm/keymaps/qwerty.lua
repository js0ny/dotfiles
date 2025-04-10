local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

M.qwerty = {

  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "J",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "K",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "L",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
}

local leader_common = require("keymaps.leaders").common

for _, v in ipairs(leader_common) do
  table.insert(M.leader, v)
end

return M
