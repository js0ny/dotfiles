-- vim: foldmethod=marker  foldmarker=#region,#endregion
-- Reference to: https://github.com/KevinSilvester/wezterm-config/blob/master/config/bindings.lua
local wezterm = require("wezterm")
local action = wezterm.action
local act = wezterm.action
local os_type = require("utils").detected_os

local SUPER

if os_type.is_mac then
  SUPER = "SUPER"
else
  SUPER = "ALT"
end

local layout = require("keymaps.colemak")

-- #region Key Tables
local key_tables = {
  copy_mode = {
    -- #region Built-in CopyMode
    -- This keymaps seems cannot be merged.
    { key = "Tab",    mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
    { key = "Tab",    mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
    { key = "Enter",  mods = "NONE",  action = act.CopyMode("MoveToStartOfNextLine") },
    { key = "Escape", mods = "NONE",  action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
    { key = "Space",  mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "$",      mods = "NONE",  action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "$",      mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = ",",      mods = "NONE",  action = act.CopyMode("JumpReverse") },
    { key = "0",      mods = "NONE",  action = act.CopyMode("MoveToStartOfLine") },
    { key = ";",      mods = "NONE",  action = act.CopyMode("JumpAgain") },
    { key = "F",      mods = "NONE",  action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
    { key = "F",      mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
    { key = "G",      mods = "NONE",  action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "G",      mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },
    { key = "H",      mods = "NONE",  action = act.CopyMode("MoveToViewportTop") },
    { key = "H",      mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
    { key = "L",      mods = "NONE",  action = act.CopyMode("MoveToViewportBottom") },
    { key = "L",      mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },
    { key = "M",      mods = "NONE",  action = act.CopyMode("MoveToViewportMiddle") },
    { key = "M",      mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
    { key = "O",      mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
    { key = "O",      mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
    { key = "T",      mods = "NONE",  action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
    { key = "T",      mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
    { key = "V",      mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "V",      mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },
    { key = "^",      mods = "NONE",  action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "^",      mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "b",      mods = "NONE",  action = act.CopyMode("MoveBackwardWord") },
    { key = "b",      mods = "ALT",   action = act.CopyMode("MoveBackwardWord") },
    { key = "b",      mods = "CTRL",  action = act.CopyMode("PageUp") },
    { key = "c",      mods = "CTRL",  action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
    { key = "d",      mods = "CTRL",  action = act.CopyMode({ MoveByPage = 0.5 }) },
    { key = "e",      mods = "NONE",  action = act.CopyMode("MoveForwardWordEnd") },
    { key = "f",      mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = false } }) },
    { key = "f",      mods = "ALT",   action = act.CopyMode("MoveForwardWord") },
    { key = "f",      mods = "CTRL",  action = act.CopyMode("PageDown") },
    { key = "g",      mods = "NONE",  action = act.CopyMode("MoveToScrollbackTop") },
    { key = "g",      mods = "CTRL",  action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
    { key = "h",      mods = "NONE",  action = act.CopyMode("MoveLeft") },
    { key = "j",      mods = "NONE",  action = act.CopyMode("MoveDown") },
    { key = "k",      mods = "NONE",  action = act.CopyMode("MoveUp") },
    { key = "l",      mods = "NONE",  action = act.CopyMode("MoveRight") },
    { key = "m",      mods = "ALT",   action = act.CopyMode("MoveToStartOfLineContent") },
    { key = "o",      mods = "NONE",  action = act.CopyMode("MoveToSelectionOtherEnd") },
    { key = "q",      mods = "NONE",  action = act.Multiple({ "ScrollToBottom", { CopyMode = "Close" } }) },
    { key = "t",      mods = "NONE",  action = act.CopyMode({ JumpForward = { prev_char = true } }) },
    { key = "u",      mods = "CTRL",  action = act.CopyMode({ MoveByPage = -0.5 }) },
    { key = "v",      mods = "NONE",  action = act.CopyMode({ SetSelectionMode = "Cell" }) },
    { key = "v",      mods = "CTRL",  action = act.CopyMode({ SetSelectionMode = "Block" }) },
    { key = "w",      mods = "NONE",  action = act.CopyMode("MoveForwardWord") },
    {
      key = "y",
      mods = "NONE",
      action = act.Multiple({
        { CopyTo = "ClipboardAndPrimarySelection" },
        { Multiple = { "ScrollToBottom", { CopyMode = "Close" } } },
      }),
    },
    { key = "PageUp",     mods = "NONE", action = act.CopyMode("PageUp") },
    { key = "PageDown",   mods = "NONE", action = act.CopyMode("PageDown") },
    { key = "End",        mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
    { key = "Home",       mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
    { key = "LeftArrow",  mods = "NONE", action = act.CopyMode("MoveLeft") },
    { key = "LeftArrow",  mods = "ALT",  action = act.CopyMode("MoveBackwardWord") },
    { key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "RightArrow", mods = "ALT",  action = act.CopyMode("MoveForwardWord") },
    { key = "UpArrow",    mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "DownArrow",  mods = "NONE", action = act.CopyMode("MoveDown") },
    -- #endregion
    -- #region Customized CopyMode
    { key = "n",          mods = "NONE", action = act.CopyMode("MoveDown") },
    { key = "e",          mods = "NONE", action = act.CopyMode("MoveUp") },
    { key = "i",          mods = "NONE", action = act.CopyMode("MoveRight") },
    { key = "j",          mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
    -- #endregion
  },
  resize_pane = {
    { key = "h", mods = "NONE", action = act.AdjustPaneSize({ "Left", 1 }) },
    { key = "n", mods = "NONE", action = act.AdjustPaneSize({ "Down", 1 }) },
    { key = "e", mods = "NONE", action = act.AdjustPaneSize({ "Up", 1 }) },
    { key = "i", mods = "NONE", action = act.AdjustPaneSize({ "Right", 1 }) },
    { key = "q", mods = "NONE", action = "PopKeyTable" },
  },
}
-- #endregion

local leader_keys = layout.leader


-- #region Ctrl Keymaps
local ctrl_keys = {
  {
    key = "W",
    mods = "CTRL",
    action = act.CloseCurrentPane({ confirm = true }),
  },
  { -- ^C to copy if selection is active, otherwise send signal
    -- https://wezfurlong.org/wezterm/config/lua/keyassignment/ClearSelection.html?h=selection
    key = "c",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)

        window:perform_action(act.ClearSelection, pane)
      else
        window:perform_action(act.SendKey({ key = "c", mods = "CTRL" }), pane)
      end
    end),
  },
}
-- #endregion

-- #region SUPER Keymaps
local super_keys = {
  { key = "LeftArrow",  mods = SUPER, action = act.SendString("\u{1b}OH") },
  { key = "RightArrow", mods = SUPER, action = act.SendString("\u{1b}OF") },
  { key = "Backspace",  mods = SUPER, action = act.SendString("\u{15}") },
  { key = "0",          mods = SUPER, action = act.ActivateTab(-1) },
  { key = "t",          mods = SUPER, action = act.SpawnTab("DefaultDomain") },
  { key = "w",          mods = SUPER, action = act.CloseCurrentTab({ confirm = false }) },
}
for i = 1, 9 do
  table.insert(super_keys, { key = tostring(i), mods = SUPER, action = act.ActivateTab(i - 1) })
end
-- #endregion

-- Concat all keymaps
local keys = {}

for _, keymap in ipairs(leader_keys) do
  table.insert(keys, keymap)
end

for _, keymap in ipairs(ctrl_keys) do
  table.insert(keys, keymap)
end

for _, keymap in ipairs(super_keys) do
  table.insert(keys, keymap)
end

return function(config)
  config.leader = { key = "q", mods = "CTRL" }
  config.keys = keys
  config.key_tables = key_tables
  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = act.OpenLinkAtMouseCursor,
    },
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "SUPER",
      action = act.OpenLinkAtMouseCursor,
    },
  }
end
