-- I forgot why I keep this plugin, I use snacks.nvim currently

return {}

-- 2025-03-03
-- If current session is not spawn by neovide, do not load image.nvim
-- neovide did not support image viewer yet
-- https://github.com/neovide/neovide/issues/2088
-- Disable on: Neovide, alacritty and windows
-- if vim.g.neovide then
--   return {}
-- elseif vim.env.TERM_PROGRAM == "alacritty" then
--   return {}
-- elseif vim.loop.os_uname().sysname:lower() == "windows_nt" then
--   return {}
-- else
--   return {
--     "3rd/image.nvim",
--     opts = {},
--     event = "BufReadPre",
--   }
-- end
