-- 2025-03-03
-- If current session is not spawn by neovide, do not load image.nvim
-- neovide did not support image viewer yet
-- https://github.com/neovide/neovide/issues/2088
if vim.g.neovide then
  return {}
elseif vim.env.TERM_PROGRAM == "alacritty" then
  return {}
else
  return {
    "3rd/image.nvim",
    opts = {},
    event = "BufReadPre",
  }
end
