-- $DOTFILES/tools\wezterm\wezterm.lua
-- Date: 2024-12-22
-- Author: js0ny

-- Location:
-- $XDG_CONFIG_HOME/wezterm/wezterm.lua
-- Linking:
-- ln -sf $DOTFILES/tools/wezterm/wezterm.lua $XDG_CONFIG_HOME/wezterm/wezterm.lua

local wezterm = require 'wezterm'

local config = {}

local os_type = ""
if package.config:sub(1,1) == "\\" then
    -- Windows
    os_type = "Windows"
elseif package.config:sub(1,1) == "/" then
    -- Unix-like (Linux, macOS, etc.)
    if os.getenv("HOME") then
        os_type = "Unix-like"
        -- You can differentiate further by checking for macOS or Linux if needed
        if os.getenv("XDG_SESSION_TYPE") then
            -- Likely Linux
            os_type = "Linux"
        elseif os.execute("uname -s | grep -i darwin") == 0 then
            -- macOS
            os_type = "macOS"
        end
    end
end

print("[DEBUG] Detected OS: " .. os_type)


-- Appearance
------------------
-- Font and color scheme
config.font = wezterm.font("FiraCode Nerd Font")
config.color_scheme = "Ayu Mirage"
config.font_size = 12.0
if os_type == "Windows" then
    config.window_background_opacity = 0.7
    config.win32_system_backdrop = 'Acrylic'
end
-- Tab appearance
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

-- Keybindings
------------------
config.leader = { key="q", mods="CTRL" }
config.keys = {
    {
        key = 'q',
        mods = 'LEADER',
        action = wezterm.action.SendKey {key = 'q', mods = 'CTRL'},
    },
    -- Windows Management
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}
    },
    {
        key = '-',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical{domain="CurrentPaneDomain"}
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Left'
    },
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Down'
    },
    {
        key = 'e',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Up'
    },
    {
        key = 'i',
        mods = 'LEADER',
        action = wezterm.action.ActivatePaneDirection 'Right'
    },
    {
        key = 'H',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Left', 5  },
    },
    {
        key = 'N',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Down', 5  },
    },
    {
        key = 'E',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Up', 5    },
    },
    {
        key = 'I',
        mods = 'LEADER',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
}
-- Environment
------------------
if os_type == "Windows" then
    config.default_prog = { "pwsh.exe" }
else
    config.default_prog = { "fish" }
end
config.set_environment_variables = {
    WEZTERM="true",
}
return config
