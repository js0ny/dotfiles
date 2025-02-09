local wezterm = require("wezterm")

local function is_found(str, pattern)
  return string.find(str, pattern) ~= nil
end

local M = {}

local function platform()
  local is_win = is_found(wezterm.target_triple, "windows")
  local is_linux = is_found(wezterm.target_triple, "linux")
  local is_mac = is_found(wezterm.target_triple, "apple")
  local os

  if is_win then
    os = "windows"
  elseif is_linux then
    os = "linux"
  elseif is_mac then
    os = "mac"
  else
    error("Unknown platform")
  end

  return {
    os = os,
    is_win = is_win,
    is_linux = is_linux,
    is_mac = is_mac,
  }
end

local _platform = platform()

M.detected_os = _platform

return M
