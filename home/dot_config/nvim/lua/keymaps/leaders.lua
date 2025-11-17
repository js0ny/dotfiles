local M = {}

local formatFx = function()
  require("conform").format({ async = true })
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

-- stylua: ignore start
local leader_mappings = {
  general = {
    { keys = "-",     cmd = ":split<CR>",          opts = { desc = "Split to down" } },
    { keys = "\\",    cmd = ":vsplit<CR>",         opts = { desc = "Split to right" } },
    { keys = "|",     cmd = ":vsplit<CR>",         opts = { desc = "Split to right" } },
    { keys = "h",     cmd = "<C-w>h",              opts = { desc = "Left Window" } },
    { keys = "n",     cmd = "<C-w>j",              opts = { desc = "Down Window" } },
    { keys = "e",     cmd = "<C-w>k",              opts = { desc = "Up Window" } },
    { keys = "i",     cmd = "<C-w>l",              opts = { desc = "Right Window" } },
    { keys = "<Tab>", cmd = "<Cmd>b#<CR>",         opts = { desc = "Switch to last buffer" } },
    { keys = '"',     cmd = ":!wezterm-gui &<CR>", pots = { desc = "Open External Terminal(wezterm)" } },
  },
  b = { -- +buffer
    { keys = "0",  cmd = "<Cmd>b#<CR>",                 opts = { desc = "Switch to last buffer" } },
    { keys = "1",  cmd = ":BufferLineGotoBuffer 1<CR>", opts = { desc = "Switch to Buffer #1" } },
    { keys = "2",  cmd = ":BufferLineGotoBuffer 2<CR>", opts = { desc = "Switch to Buffer #2" } },
    { keys = "3",  cmd = ":BufferLineGotoBuffer 3<CR>", opts = { desc = "Switch to Buffer #3" } },
    { keys = "4",  cmd = ":BufferLineGotoBuffer 4<CR>", opts = { desc = "Switch to Buffer #4" } },
    { keys = "5",  cmd = ":BufferLineGotoBuffer 5<CR>", opts = { desc = "Switch to Buffer #5" } },
    { keys = "6",  cmd = ":BufferLineGotoBuffer 6<CR>", opts = { desc = "Switch to Buffer #6" } },
    { keys = "7",  cmd = ":BufferLineGotoBuffer 7<CR>", opts = { desc = "Switch to Buffer #7" } },
    { keys = "8",  cmd = ":BufferLineGotoBuffer 8<CR>", opts = { desc = "Switch to Buffer #8" } },
    { keys = "9",  cmd = ":BufferLineGotoBuffer 9<CR>", opts = { desc = "Switch to Buffer #9" } },
    { keys = "b",  cmd = ":BufferLinePick<CR>",         opts = { desc = "Quick Switch Buffers" } },
    { keys = "d",  cmd = ":bdelete<CR>",                opts = { desc = "Delete Buffer" } },
    { keys = "D",  cmd = ":BufferLineCloseOthers<CR>",  opts = { desc = "Delete Other Buffers" } },
    { keys = "xx", cmd = ":BufferLineCloseOthers<CR>",  opts = { desc = "Delete Other Buffers" } },
    { keys = "xh", cmd = ":BufferLineCloseLeft<CR>",    opts = { desc = "Delete Buffers Left" } },
    { keys = "xi", cmd = ":BufferLineCloseRight<CR>",   opts = { desc = "Delete Buffers Right" } },
    { keys = "X",  cmd = ":BufferLineCloseOthers<CR>",  opts = { desc = "Delete Other Buffers" } },
    { keys = "h",  cmd = ":bprevious<CR>",              opts = { desc = "Previous Buffer" } },
    { keys = "i",  cmd = ":bnext<CR>",                  opts = { desc = "Next Buffer" } },
    { keys = "H",  cmd = ":bfirst<CR>",                 opts = { desc = "First Buffer" } },
    { keys = "I",  cmd = ":blast<CR>",                  opts = { desc = "Last Buffer" } },
    { keys = "0",  cmd = ":bfirst<CR>",                 opts = { desc = "First Buffer" } },
    { keys = "^",  cmd = ":bfirst<CR>",                 opts = { desc = "First Buffer" } },
    { keys = "$",  cmd = ":blast<CR>",                  opts = { desc = "Last Buffer" } },
    { keys = "s",  cmd = ":new<CR>",                    opts = { desc = "Scratch buffers" } },
    { keys = "t",  cmd = ":BufferLineTogglePin<CR>",    opts = { desc = "Pin Buffer" } },
    { keys = "y",  cmd = ":%y+<CR>",                    opts = { desc = "Copy Buffer to Clipboard" } },
  },
  c = { -- +code/compile
    { keys = "R", cmd = vim.lsp.buf.rename, opts = { desc = "Rename symbol under cursor" } },
    { keys = "f", cmd = formatFx,           opts = { desc = "Format buffer" } },
  },
  f = { -- +file/find
    { keys = "n",  cmd = ":new<CR>",                      opts = { desc = "New File" } },
    { keys = "s",  cmd = ":write<CR>",                    opts = { desc = "Save File" } },
    { keys = "S",  cmd = ":wall<CR>",                     opts = { desc = "Save All Files" } },
    { keys = "D",  cmd = "!trash-rm %<CR>",               opts = { desc = "Delete current file" } },
    -- { keys = "t", cmd = ":NvimTreeFindFileToggle<CR>", opts = { desc = "Toggle File Tree" } },
    -- { keys = "o",  cmd = ":!open %<CR>",                  opts = { desc = "Open file in default program" } },
    { keys = "R",  cmd = "<cmd>Rename<CR>",               opts = { desc = "Rename current file" } },
    { keys = "x",  cmd = ":Lazy<CR>",                     opts = { desc = "Open extension view" } },
    { keys = "yy", cmd = ":let @+ = expand('%:p')<CR>",   opts = { desc = "Copy file path" } },
    { keys = "yY", cmd = ":let @+ = expand('%')<CR>",     opts = { desc = "Copy relative file path" } },
    { keys = "yn", cmd = ":let @+ = expand('%:t')<CR>",   opts = { desc = "Copy file name" } },
    { keys = "yN", cmd = ":let @+ = expand('%:t:r')<CR>", opts = { desc = "Copy file name without extension" } },
    { keys = "yd", cmd = ":let @+ = expand('%:p:h')<CR>", opts = { desc = "Copy directory path" } },
    {
      keys = "yl",
      cmd = ":let @+ = expand('%:p') . ':' . line('.')<CR>",
      opts = { desc = "Copy file path with line number" },
    },
    {
      keys = "yL",
      cmd = ":let @+ = expand('%') . ':' . line('.')<CR>",
      opts = { desc = "Copy relative file path with line number" },
    },
  },
  g = { -- +git/version control
  },
  j = { -- +lsp
    { keys = "r", cmd = vim.lsp.buf.references, opts = { desc = "Show current reference" } },
  },
  p = { -- +project
  },
  q = { -- +quit
    { keys = "q", cmd = ":q<CR>",            opts = { desc = "Quit" } },
    { keys = "Q", cmd = ":qa!<CR>",          opts = { desc = "Force Quit" } },
    { keys = "w", cmd = ":wq<CR>",           opts = { desc = "Write and Quit" } },
    { keys = "W", cmd = ":wall<CR>:qa!<CR>", opts = { desc = "Write all and Force Quit" } },
  },
  t = { -- +toggle/test
    { keys = "f", cmd = ":NvimTreeToggle",   opts = { desc = "Toggle File Explorer" } },
    { keys = "F", cmd = ":FormatToggle<CR>", opts = { desc = "Toggle autoformat-on-save" } },
  },
  u = { -- +ui
    { keys = " ", cmd = ":set list!", opts = { desc = "Toggle show all symbols" } },
  },
  w = { -- +window
    { keys = "h", cmd = "<C-w>h",                          opts = { desc = "Left Window" } },
    { keys = "j", cmd = "<C-w>j",                          opts = { desc = "Down Window" } },
    { keys = "k", cmd = "<C-w>k",                          opts = { desc = "Up Window" } },
    { keys = "l", cmd = "<C-w>l",                          opts = { desc = "Right Window" } },
    { keys = "H", cmd = "<C-w>H",                          opts = { desc = "Move Window Left" } },
    { keys = "J", cmd = "<C-w>J",                          opts = { desc = "Move Window Down" } },
    { keys = "K", cmd = "<C-w>K",                          opts = { desc = "Move Window Up" } },
    { keys = "L", cmd = "<C-w>L",                          opts = { desc = "Move Window Right" } },
    { keys = "-", cmd = ":split<CR>",                      opts = { desc = "Split to down" } },
    { keys = "|", cmd = ":vsplit<CR>",                     opts = { desc = "Split to right" } },
    { keys = "/", cmd = ":vsplit<CR>",                     opts = { desc = "Split to right" } },
    { keys = "d", cmd = "<C-w>c",                          opts = { desc = "Close Window" } },
    { keys = "D", cmd = "<C-w>o",                          opts = { desc = "Close Other Windows" } },
    { keys = "r", cmd = "<C-w>r",                          opts = { desc = "Rotate Windows" } },
    { keys = "R", cmd = "<C-w>R",                          opts = { desc = "Reverse Rotate Windows" } },
    { keys = "t", cmd = "<C-w>T",                          opts = { desc = "Move Window to New Tab" } },
    { keys = "]", cmd = ":resize +5<CR>",                  opts = { desc = "Increase Window Size" } },
    { keys = "[", cmd = ":resize -5<CR>",                  opts = { desc = "Decrease Window Size" } },
    { keys = "M", cmd = ":resize<CR>:vertical resize<CR>", opts = { desc = "Maximize window size" } },
  },
}
-- stylua: ignore end

for key, maps in pairs(leader_mappings) do
  if key == "general" then
    apply_mappings(maps, "<leader>")
  else
    apply_mappings(maps, "<leader>" .. key)
  end
end

return M
