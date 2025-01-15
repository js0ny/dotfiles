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

-- 通用映射函数
local function apply_mappings(maps, prefix)
  for _, map in ipairs(maps) do
    local new_map = {
      keys = prefix .. map.keys,
      cmd = map.cmd,
      opts = map.opts,
    }
    table.insert(M, new_map)
  end
end
vim.api.nvim_create_user_command("Rename", renameCurrentBuffer, {})

local leader_mappings = {
  general = {
    { keys = "<leader>", cmd = ":Telescope find_files<CR>", opts = { desc = "Find Files" } },
    { keys = "/", cmd = ":Telescope live_grep<CR>", opts = { desc = "Grep Files" } },
    { keys = "-", cmd = ":split<CR>", opts = { desc = "Split to down" } },
    { keys = "\\", cmd = ":vsplit<CR>", opts = { desc = "Split to right" } },
    { keys = "|", cmd = ":vsplit<CR>", opts = { desc = "Split to right" } },
    { keys = "h", cmd = "<C-w>h", opts = { desc = "Left Window" } },
    { keys = "n", cmd = "<C-w>j", opts = { desc = "Down Window" } },
    { keys = "e", cmd = "<C-w>k", opts = { desc = "Up Window" } },
    { keys = "i", cmd = "<C-w>l", opts = { desc = "Right Window" } },
    { keys = "<Tab>", cmd = "<Cmd>b#<CR>", opts = { desc = "Switch to last buffer" } },
    { keys = "!", cmd = ":FloatermToggle<CR>", opts = { desc = "" } },
  },
  b = { -- +buffer
    { keys = "a", cmd = ":Alpha<CR>", opts = { desc = "Dashboard" } },
    { keys = "b", cmd = ":Telescope buffers<CR>", opts = { desc = "List Buffers" } },
    { keys = "d", cmd = ":bdelete<CR>", opts = { desc = "Delete Buffer" } },
    { keys = "h", cmd = ":bprevious<CR>", opts = { desc = "Previous Buffer" } },
    { keys = "i", cmd = ":bnext<CR>", opts = { desc = "Next Buffer" } },
    { keys = "H", cmd = ":bfirst<CR>", opts = { desc = "First Buffer" } },
    { keys = "I", cmd = ":blast<CR>", opts = { desc = "Last Buffer" } },
    { keys = "0", cmd = ":bfirst<CR>", opts = { desc = "First Buffer" } },
    { keys = "^", cmd = ":bfirst<CR>", opts = { desc = "First Buffer" } },
    { keys = "$", cmd = ":blast<CR>", opts = { desc = "Last Buffer" } },
    -- { keys = "s", cmd = ":Telescope buffers<CR>", opts = { desc = "Search buffers" } },
  },
  c = { -- +code/compile
    { keys = "r", cmd = ":RunCode<CR>", opts = { desc = "Run code" } },
    { keys = "e", cmd = ":Telescope diagnostics<CR>", opts = { desc = "Navigate errors/warnings" } },
    { keys = "f", cmd = formatFx, opts = { desc = "Format buffer" } },
    { keys = "s", cmd = ":Telescope treesitter<CR>", opts = { desc = "Search symbols" } },
    { keys = "S", cmd = ":Telescope grep_string<CR>", opts = { desc = "Search current symbol" } },
  },
  f = { -- +file/find
    { keys = "f", cmd = ":Telescope fd<CR>", opts = { desc = "Find Files" } },
    { keys = "s", cmd = ":Telescope live_grep<CR>", opts = { desc = "Grep Files" } },
    { keys = "b", cmd = ":Telescope buffers<CR>", opts = { desc = "List Buffers" } },
    { keys = "e", cmd = ":NvimTreeToggle<CR>", opts = { desc = "Toggle File Explorer" } },
    { keys = "t", cmd = ":FloatermToggle<CR>", opts = { desc = "toggle visibility of the float terminal" } },
    { keys = "T", cmd = ":FloatermNew<CR>", opts = { desc = "Spawn a float terminal" } },
    { keys = "h", cmd = ":Telescope oldfiles<CR>", opts = { desc = "Search history files" } },
    { keys = "c", cmd = ":Telescope find_files cwd=~/.config/nvim<CR>", opts = { desc = "Search Config" } },
    { keys = "o", cmd = ":!open %", opts = { desc = "Open file in default program" } },
    { keys = "R", cmd = renameCurrentBuffer, opts = { desc = "Rename current file" } },
  },
  p = { -- +project
    { keys = "p", cmd = ":Telescope projects<CR>", opts = { desc = "List all Projects" } },
    { keys = "g", cmd = ":Telescope projects<CR>", opts = { desc = "List all Git Projects" } },
    { keys = "s", cmd = ":Telescope session-lens<CR>", opts = { desc = "List all sessions" } },
  },
  q = { -- +quit
    { keys = "q", cmd = ":q<CR>", opts = { desc = "Quit" } },
    { keys = "Q", cmd = ":qa!<CR>", opts = { desc = "Force Quit" } },
    { keys = "w", cmd = ":wq<CR>", opts = { desc = "Write and Quit" } },
    { keys = "W", cmd = ":wall<CR>:qa!<CR>", opts = { desc = "Write all and Force Quit" } },
  },
  t = { -- +toggle
    { keys = "f", cmd = ":NvimTreeToggle", opts = { desc = "Toggle File Explorer" } },
    { keys = "F", cmd = ":FormatToggle<CR>", opts = { desc = "Toggle autoformat-on-save" } },
    { keys = "t", cmd = ":FloatermToggle<CR>", opts = { desc = "toggle visibility of the float terminal" } },
  },
  u = { -- +ui
    { keys = "i", cmd = ":Telescope colorscheme<CR>", opts = { desc = "Change colorscheme" } },
  },
  w = { -- +window
    { keys = "h", cmd = "<C-w>h", opts = { desc = "Left Window" } },
    { keys = "n", cmd = "<C-w>j", opts = { desc = "Down Window" } },
    { keys = "e", cmd = "<C-w>k", opts = { desc = "Up Window" } },
    { keys = "i", cmd = "<C-w>l", opts = { desc = "Right Window" } },
    { keys = "-", cmd = ":split<CR>", opts = { desc = "Split to down" } },
    { keys = "|", cmd = ":vsplit<CR>", opts = { desc = "Split to right" } },
    { keys = "c", cmd = "<C-w>c", opts = { desc = "Close Window" } },
    { keys = "o", cmd = "<C-w>o", opts = { desc = "Close Other Windows" } },
    { keys = "r", cmd = "<C-w>r", opts = { desc = "Rotate Windows" } },
    { keys = "R", cmd = "<C-w>R", opts = { desc = "Reverse Rotate Windows" } },
    { keys = "t", cmd = "<C-w>T", opts = { desc = "Move Window to New Tab" } },
    { keys = "H", cmd = ":vertical resize -5<CR>", opts = { desc = "Decrease Window Height" } },
    { keys = "N", cmd = ":resize +5<CR>", opts = { desc = "Increase Window Height" } },
    { keys = "E", cmd = ":vertical resize +5<CR>", opts = { desc = "Increase Window Width" } },
    { keys = "I", cmd = ":resize -5<CR>", opts = { desc = "Decrease Window Width" } },
  },
}

for key, maps in pairs(leader_mappings) do
  if key == "general" then
    apply_mappings(maps, "<leader>")
  else
    apply_mappings(maps, "<leader>" .. key)
  end
end

return M
