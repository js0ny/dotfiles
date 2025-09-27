local M = {}
local wezterm = require("wezterm")
local act = wezterm.action

M.leader = {
  {
    key = "n",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "e",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "i",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "N",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "E",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "I",
    mods = "LEADER",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
}

local leader_common = require("keymaps.leaders").common

for _, v in ipairs(leader_common) do
  table.insert(M.leader, v)
end

return M
