local M = {
  {
    keys = "<C-w>h",
    cmd = "<C-\\><C-n><C-w>h",
    opts = { desc = "Terminal window left", silent = true },
  },
  {
    keys = "<C-w>j",
    cmd = "<C-\\><C-n><C-w>j",
    opts = { desc = "Terminal window down", silent = true },
  },
  {
    keys = "<C-w>k",
    cmd = "<C-\\><C-n><C-w>k",
    opts = { desc = "Terminal window up", silent = true },
  },
  {
    keys = "<C-w>l",
    cmd = "<C-\\><C-n><C-w>l",
    opts = { desc = "Terminal window right", silent = true },
  },
  {
    keys = "<C-w>",
    cmd = "<C-\\><C-n><C-w>",
    opts = { desc = "Terminal window prefix", silent = true },
  },
}

for _, map in ipairs(M) do
  map.mode = "t"
end

return M
