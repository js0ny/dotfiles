local M = {}

local leader_general = {
  { keys = "<space>", cmd = ":Telescope find_files<CR>", desc = "Find Files" },
  { keys = "/",       cmd = ":Telescope live_grep<CR>",  desc = "Grep Files" },
}

for _,map in ipairs(leader_general) do
  map.keys = "<leader>" .. map.keys
  table.insert(M, map)
end

local leader_q = { -- leader q: Quit
  { keys = "q", cmd = ":q<CR>", desc = "Quit" },
  { keys = "Q", cmd = ":qa!<CR>", desc = "Force Quit" },
  { keys = "w", cmd = ":wq<CR>", desc = "Write and Quit" },
  { keys = "W", cmd = ":wall<CR>:qa!<CR>", desc = "Write all and Force Quit" },
}

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

local leader_f = { -- leader f: Files/Find
  { keys = "f", cmd = ":Telescope fd<CR>", desc = "Find Files"},
  { keys = "s", cmd = ":Telescope live_grep<CR>", desc = "Grep Files"},
  { keys = "b", cmd = ":Telescope buffers<CR>", desc = "List Buffers"},
  { keys = "e", cmd = ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
}

local leader_p = { -- leader p: Project
}

local leader_b = { -- leader b: Buffer
  { keys = "d", cmd = ":bdelete<CR>", desc = "Delete Buffer" },
  { keys = "h", cmd = ":bprevious<CR>", desc = "Previous Buffer" },
  { keys = "i", cmd = ":bnext<CR>", desc = "Next Buffer" },
  { keys = "H", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "I", cmd = ":blast<CR>", desc = "Last Buffer" },
  { keys = "0", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "^", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "$", cmd = ":blast<CR>", desc = "Last Buffer" },
}

for _, map in ipairs(leader_q) do
  map.keys = "<leader>q" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_w) do
  map.keys = "<leader>w" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_f) do
  map.keys = "<leader>f" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_b) do
  map.keys = "<leader>b" .. map.keys
  table.insert(M, map)
end

return M
