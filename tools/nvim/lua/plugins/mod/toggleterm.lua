local function get_highlight()
  if vim.g.colors_name == "catppuccin" then
    -- NOTE: This won't work since no integration is available
    return require("catppuccin.groups.integrations.bufferline").get()
    -- return require("rose-pine.plugins.toggleterm")
  elseif vim.g.colors_name == "rose-pine" then
    return require("rose-pine.plugins.toggleterm")
  end
end

return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>!", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal" },
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Spawn a float terminal" },
    -- TODO: Implement lazygit
    -- {
    --   "<leader>gg",
    --   "<cmd>lua _lazygit_toggle()<CR>",
    --   -- require("toggleterm.terminal").Terminal:new({ cmd = "lazygit", hidden = true }),
    --   desc = "Toggle LazyGit",
    -- },
  },
  event = "ColorScheme",
  opts = {
    highlights = get_highlight(),
  },
  cmd = {
    "ToggleTerm",
    "LazyGit",
  },
}
