-- Change the colorscheme here, use SPACE u i or :FzfLua colorscheme to change colorscheme

-- https://www.reddit.com/r/neovim/comments/1d3hk1t/automatic_dark_mode_following_system_theme_on/
local function get_system_theme()
  -- Default value
  local background = 'light'
  -- First check whether we are on MacOS
  if vim.loop.os_uname().sysname == "Darwin" then
    -- Check if 'defaults' is executable
    if vim.fn.executable('defaults') ~= 0 then
      -- Execute command to check if the macOS appearance is set to Dark
      local appleInterfaceStyle = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
      if appleInterfaceStyle:find("Dark") then
        background = 'dark'
      end
    end
    -- Check if 'busctl' is executable (part of systemd)
  elseif vim.fn.executable('busctl') ~= 0 then
    -- Get the current color scheme from xdg-desktop-portal using busctl
    local result = vim.fn.system({
      "busctl", "--user", "call", "org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop",
      "org.freedesktop.portal.Settings", "ReadOne", "ss", "org.freedesktop.appearance", "color-scheme"
    })
    -- The result is in the form of "v u 0" for light and "v u 1" for dark
    local color_scheme = result:match("u%s+(%d+)")

    if color_scheme == '1' then
      background = 'dark'
    end
  else
  end

  return background
end

if get_system_theme() == 'dark' then
  vim.o.background = 'dark'
  vim.cmd.colorscheme("catppuccin")
else
  vim.o.background = 'light'
  vim.cmd.colorscheme("rose-pine")
end
