local M = {}

local leader_general = {
  { keys = "<space>", cmd = ":Telescope find_files<CR>", desc = "Find Files" },
  { keys = "/",       cmd = ":Telescope live_grep<CR>",  desc = "Grep Files" },
}

for _,map in ipairs(leader_general) do
  map.keys = "<leader>" .. map.keys
  table.insert(M, map)
end

local leader_w = { -- leader w: Windows Management
  { keys = "h", cmd = "<C-w>h", desc = "Left Window" },
  { keys = "n", cmd = "<C-w>j", desc = "Down Window" },
  { keys = "e", cmd = "<C-w>k", desc = "Up Window" },
  { keys = "i", cmd = "<C-w>l", desc = "Right Window" },
  { keys = "-", cmd = ":split<CR>", desc = "Split to down" },
  { keys = "|", cmd = ":vsplit<CR>", desc = "Split to right" },
  { keys = "c", cmd = "<C-w>c", desc = "Close Window" },
  { keys = "o", cmd = "<C-w>o", desc = "Close Other Windows" },
  { keys = "r", cmd = "<C-w>r", desc = "Rotate Windows" },
  { keys = "R", cmd = "<C-w>R", desc = "Reverse Rotate Windows" },
  { keys = "t", cmd = "<C-w>T", desc = "Move Window to New Tab" },
  { keys = "H", cmd = ":vertical resize -5<CR>", desc = "Decrease Window Height" },
  { keys = "N", cmd = ":resize +5<CR>", desc = "Increase Window Height" },
  { keys = "E", cmd = ":vertical resize +5<CR>", desc = "Increase Window Width" },
  { keys = "I", cmd = ":resize -5<CR>", desc = "Decrease Window Width" },
}

for _, map in ipairs(leader_w) do
  map.keys = "<leader>w" .. map.keys
  table.insert(M, map)
end

return M
