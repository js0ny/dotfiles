local M = {}

local formatFx = function()
  require("conform").format({ async = true })
end

local renameCurrentBuffer = function()
  local old_name = vim.fn.expand("%:p")
  local new_name = vim.fn.input("New name: ", vim.fn.expand("%:p:h") .. "/")

  if new_name == "" then
    print("No new name provided")
    return
  elseif new_name == old_name then
    return
  end

  vim.cmd("write")

  local success, err = os.rename(old_name, new_name)
  if not success then
    print("Error renaming file: " .. err)
    return
  end

  vim.cmd("edit " .. new_name)
  vim.cmd("bdelete " .. old_name)
end

vim.api.nvim_create_user_command("Rename", renameCurrentBuffer, {})

local leader_general = {
  { keys = "<space>", cmd = ":Telescope find_files<CR>", desc = "Find Files" },
  { keys = "/", cmd = ":Telescope live_grep<CR>", desc = "Grep Files" },
  { keys = "-", cmd = ":split<CR>", desc = "Split to down" },
  { keys = "\\", cmd = ":vsplit<CR>", desc = "Split to right" },
  { keys = "|", cmd = ":vsplit<CR>", desc = "Split to right" },
  { keys = "h", cmd = "<C-w>h", desc = "Left Window" },
  { keys = "n", cmd = "<C-w>j", desc = "Down Window" },
  { keys = "e", cmd = "<C-w>k", desc = "Up Window" },
  { keys = "i", cmd = "<C-w>l", desc = "Right Window" },
}

for _, map in ipairs(leader_general) do
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

local leader_f = { -- <leader>f: +files/find
  { keys = "f", cmd = ":Telescope fd<CR>", desc = "Find Files" },
  { keys = "s", cmd = ":Telescope live_grep<CR>", desc = "Grep Files" },
  { keys = "b", cmd = ":Telescope buffers<CR>", desc = "List Buffers" },
  { keys = "e", cmd = ":NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
  { keys = "t", cmd = ":FloatermToggle<CR>", desc = "toggle visibility of the float terminal" },
  { keys = "T", cmd = ":FloatermNew<CR>", desc = "Spawn a float terminal" },
  { keys = "h", cmd = ":Telescope oldfiles<CR>", desc = "Search history files" },
  { keys = "c", cmd = ":Telescope find_files cwd=~/.config/nvim<CR>", desc = "Search Config" },
  { keys = "o", cmd = ":!open %", desc = "Open file in default program" },
  { keys = "R", cmd = renameCurrentBuffer, desc = "Rename current file" },
}

local leader_p = { -- leader p: Project
  { keys = "p", cmd = ":Telescope projects<CR>", desc = "List all Projects" },
  { keys = "g", cmd = ":Telescope projects<CR>", desc = "List all Git Projects" },
  { keys = "s", cmd = ":Telescope session-lens<CR>", desc = "List all sessions" },
}

local leader_b = { -- <leader>b: +buffer
  { keys = "a", cmd = ":Alpha<CR>", desc = "Dashboard" },
  { keys = "b", cmd = ":Telescope buffers<CR>", desc = "List Buffers" },
  { keys = "d", cmd = ":bdelete<CR>", desc = "Delete Buffer" },
  { keys = "h", cmd = ":bprevious<CR>", desc = "Previous Buffer" },
  { keys = "i", cmd = ":bnext<CR>", desc = "Next Buffer" },
  { keys = "H", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "I", cmd = ":blast<CR>", desc = "Last Buffer" },
  { keys = "0", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "^", cmd = ":bfirst<CR>", desc = "First Buffer" },
  { keys = "$", cmd = ":blast<CR>", desc = "Last Buffer" },
  -- { keys = "s", cmd = ":Telescope buffers<CR>", desc = "Search buffers" },
}

local leader_t = { -- <leader>t: +toggle/test
  { keys = "f", cmd = ":NvimTreeToggle", desc = "Toggle File Explorer" },
  { keys = "F", cmd = ":FormatToggle<CR>", desc = "Toggle autoformat-on-save" },
  { keys = "t", cmd = ":FloatermToggle<CR>", desc = "toggle visibility of the float terminal" },
}

local leader_c = { -- <leader>c: +code/compile
  { keys = "r", cmd = ":RunCode<CR>", desc = "Run code" },
  { keys = "e", cmd = ":Telescope diagnostics<CR>", desc = "Navigate errors/warnings" },
  { keys = "f", cmd = formatFx, desc = "Format buffer" },
  { keys = "s", cmd = ":Telescope treesitter<CR>", desc = "Search symbols" },
  { keys = "S", cmd = ":Telescope grep_string<CR>", desc = "Search current symbol" },
}

local leader_u = { -- <leader>u: +ui
  { keys = "i", cmd = ":Telescope colorscheme<CR>", desc = "Change colorscheme" },
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

for _, map in ipairs(leader_c) do
  map.keys = "<leader>c" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_t) do
  map.keys = "<leader>t" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_u) do
  map.keys = "<leader>u" .. map.keys
  table.insert(M, map)
end

for _, map in ipairs(leader_p) do
  map.keys = "<leader>p" .. map.keys
  table.insert(M, map)
end

return M
