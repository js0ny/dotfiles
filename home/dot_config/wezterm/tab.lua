local wezterm = require("wezterm")
local nf = wezterm.nerdfonts
local color = require("color")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
tabline.setup({
  options = {
    icons_enabled = true,
    theme = "Catppuccin Mocha",
    tabs_enabled = true,
    theme_overrides = {
      tab = {
        inactive = { bg = color.crust , fg = color.text },
        active = { fg = color.lavender, bg = color.base },
        inactive_hover = { fg = color.pink, bg = color.surface0 },
      },
      normal_mode = {
        a = { fg = color.mantle, bg = color.lavender }, -- bg: Lavender (Mocha)
        b = { fg = color.lavender, bg = color.surface0 }, -- fg: Lavender (Mocha)
        c = { bg = color.base, fg = color.text },
      },
      copy_mode = {
        c = { bg = color.base, fg = color.text },
      },
      search_mode = {
        c = { bg = color.base, fg = color.text },
      },
      window_mode = {
        c = { bg = color.base, fg = color.text },
      },
    },
    section_separators = {
      left = nf.ple_flame_thick,
      right = nf.ple_flame_thick_mirrored,
    },
    component_separators = {
      left = nf.ple_flame_thick,
      right = nf.ple_flame_thick_mirrored,
    },
    tab_separators = {
      left = nf.ple_ice_waveform,
      right = nf.ple_ice_waveform_mirrored,
    },
  },
  sections = {
    tabline_a = {
      {
        "mode",
        icon = nf.md_alpha_w_box_outline,
        -- icons_only = true,
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    tabline_b = { "window" },
    tabline_c = { "" },
    tab_active = {
      "index",
      { "parent", padding = 0 },
      "/",
      { "cwd", padding = { left = 0, right = 1 } },
      { "zoomed", padding = 0 },
    },
    tab_inactive = {
      "index",
      {
        "process",
        padding = { left = 0, right = 1 },
        process_to_icon = {
          ["dotnet"] = { nf.dev_dotnet },
          ["dotnet.exe"] = { nf.dev_dotnet },
          ["emacs"] = { nf.custom_emacs },
          ["pwsh"] = { nf.md_powershell },
          ["pwsh.exe"] = { nf.md_powershell },
          ["powershell.exe"] = { nf.md_powershell },
          ["python3.13"] = { nf.md_language_python },
          ["less"] = { nf.fa_pager },
          ["nu"] = { nf.seti_shell },
          ["nu.exe"] = { nf.seti_shell },
        },
      },
    },
    tabline_x = {},
    tabline_y = { "ram" },
    tabline_z = { "datetime" },
  },
  extensions = {},
})

return function(config)
  config.hide_tab_bar_if_only_one_tab = true
  config.tab_bar_at_bottom = false
  -- If set to false, the tab bar will be terminal-like
  config.use_fancy_tab_bar = false
  config.colors = {
    tab_bar = {
      background = color.base,
      active_tab = {
        -- bg_color = color.pink,
        bg_color = color.lavender,
        fg_color = color.overlay0,
        italic = true,
      },
      inactive_tab = {
        bg_color = color.base,
        fg_color = color.text,
      },
      inactive_tab_hover = {
        bg_color = color.mauve,
        fg_color = color.surface2,
        italic = true,
      },
      new_tab = {
        bg_color = color.base,
        fg_color = color.text,
      },
      new_tab_hover = {
        bg_color = color.surface0,
        fg_color = color.pink,
        italic = true,
      },
    },
  }
end
