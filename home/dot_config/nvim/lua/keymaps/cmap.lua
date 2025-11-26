local M = {
  {
    keys = "<C-A>",
    cmd = "<Home>",
    opts = { desc = "Command-line beginning", silent = true },
  },
  {
    keys = "<C-E>",
    cmd = "<End>",
    opts = { desc = "Command-line end", silent = true },
  },
}

for _, map in ipairs(M) do
  map.mode = "c"
end

return M
