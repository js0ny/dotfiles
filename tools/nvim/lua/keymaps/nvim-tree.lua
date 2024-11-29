local M = {}

M.global = {
  { mode = "n", keys = "<leader>e", cmd = ":NvimTreeToggle<CR>" },
}

function M.plugin(api, opts)
  -- mode is set to "n" by default, in `./lua/plugins/nvim-tree.lua`
  return {
    -- Toggle
    { keys = "<leader>e",      cmd = ":NvimTreeToggle<CR>",              opts = opts("Toggle") },
    -- Arrow 箭头 hnei
    { keys = "h",              cmd = api.node.navigate.parent_close,     opts = opts("Close node") },
    { keys = "i",              cmd = api.node.open.edit,                 opts = opts("Open") },
    { keys = "H",              cmd = api.tree.toggle_hidden_filter,      opts = opts("Toggle Dotfiles") },
    { keys = "N",              cmd = api.node.navigate.sibling.next,     opts = opts("Next Sibling") },
    { keys = "E",              cmd = api.node.navigate.sibling.prev,     opts = opts("Previous Sibling") },
    { keys = "I",              cmd = api.tree.toggle_gitignore_filter,   opts = opts("Toggle GitIgnored") },
    -- CONTROL KEYS 控制键
    { keys = "<BS>",           cmd = api.node.navigate.parent_close,     opts = opts("Close node") },
    { keys = "<CR>",           cmd = api.node.open.edit,                 opts = opts("Open") },
    { keys = "<Tab>",          cmd = api.node.open.preview,              opts = opts("Open Preview") },
    -- Alpha 字母键
    { keys = "a",              cmd = api.fs.create,                      opts = opts("Create") },
    { keys = "A",              cmd = api.fs.create,                      opts = opts("Create") },
    { keys = "bd",             cmd = api.marks.bulk.delete,              opts = opts("Delete Bookmarked") },
    { keys = "bt",             cmd = api.marks.bulk.trash,               opts = opts("Trash Bookmarked") },
    { keys = "bmv",            cmd = api.marks.bulk.move,                opts = opts("Move Bookmarked") },
    { keys = "B",              cmd = api.tree.toggle_no_buffer_filter,   opts = opts("Toggle Filter: No Buffer") },
    { keys = "c",              cmd = api.fs.copy.node,                   opts = opts("Copy") },
    { keys = "C",              cmd = api.fs.copy.filename,               opts = opts("Copy") },
    { keys = "d",              cmd = api.fs.remove,                      opts = opts("Delete") },
    { keys = "D",              cmd = api.fs.trash,                       opts = opts("Trash") },
    { keys = "]e",             cmd = api.node.navigate.diagnostics.next, opts = opts("Next Diagnostic") },
    { keys = "[e",             cmd = api.node.navigate.diagnostics.prev, opts = opts("Prev Diagnostic") },
    { keys = "F",              cmd = api.live_filter.clear,              opts = opts("Live Filter: Clear") },
    { keys = "f",              cmd = api.live_filter.start,              opts = opts("Live Filter: Start") },
    { keys = "[g",             cmd = api.node.navigate.git.prev,         opts = opts("Prev Git") },
    { keys = "]g",             cmd = api.node.navigate.git.next,         opts = opts("Next Git") },
    { keys = "L",              cmd = api.node.open.toggle_group_empty,   opts = opts("Toggle Group Empty") },
    { keys = "M",              cmd = api.tree.toggle_no_bookmark_filter, opts = opts("Toggle Filter: No Bookmark") },
    { keys = "m",              cmd = api.marks.toggle,                   opts = opts("Toggle Bookmark") },
    { keys = "o",              cmd = api.node.open.edit,                 opts = opts("Open") },
    { keys = "O",              cmd = api.node.open.no_window_picker,     opts = opts("Open: No Window Picker") },
    { keys = "p",              cmd = api.fs.paste,                       opts = opts("Paste") },
    { keys = "P",              cmd = api.node.navigate.parent,           opts = opts("Parent Directory") },
    { keys = "q",              cmd = api.tree.close,                     opts = opts("Close") },
    { keys = "r",              cmd = api.fs.rename,                      opts = opts("Rename") },
    { keys = "R",              cmd = api.tree.reload,                    opts = opts("Refresh") },
    { keys = "s",              cmd = api.node.run.system,                opts = opts("Run System") },
    { keys = "S",              cmd = api.tree.search_node,               opts = opts("Search") },
    { keys = "u",              cmd = api.fs.rename_full,                 opts = opts("Rename: Full Path") },
    { keys = "U",              cmd = api.tree.toggle_custom_filter,      opts = opts("Toggle Filter: Hidden") },
    { keys = "W",              cmd = api.tree.collapse_all,              opts = opts("Collapse") },
    { keys = "x",              cmd = api.fs.cut,                         opts = opts("Cut") },
    { keys = "y",              cmd = api.fs.copy.relative_path,          opts = opts("Copy Relative Path") },
    { keys = "Y",              cmd = api.fs.copy.absolute_path,          opts = opts("Copy Absolute Path") },
    -- Numeric 数字键
    { keys = "!",              cmd = api.node.run.cmd,                   opts = opts("Run Command") },
    -- Non-Alphanumeric 非字母数字键
    { keys = "?",              cmd = api.tree.toggle_help,               opts = opts("Help") },
    { keys = ">",              cmd = api.node.navigate.sibling.next,     opts = opts("Next Sibling") },
    { keys = "<",              cmd = api.node.navigate.sibling.prev,     opts = opts("Previous Sibling") },
    { keys = ".",              cmd = api.node.run.cmd,                   opts = opts("Run Command") },
    { keys = ";",              cmd = api.node.run.cmd,                   opts = opts("Run Command") },
    { keys = "-",              cmd = api.tree.change_root_to_parent,     opts = opts("Up") },
    -- MOD KEYS Ctrl+
    { keys = "<C-]>",          cmd = api.tree.change_root_to_node,       opts = opts("CD") },
    { keys = "<C-e>",          cmd = api.node.open.replace_tree_buffer,  opts = opts("Open: In Place") },
    { keys = "<C-k>",          cmd = api.node.show_info_popup,           opts = opts("Info") },
    { keys = "<C-r>",          cmd = api.fs.rename_sub,                  opts = opts("Rename: Omit Filename") },
    { keys = "<C-t>",          cmd = api.node.open.tab,                  opts = opts("Open: New Tab") },
    { keys = "<C-v>",          cmd = api.node.open.vertical,             opts = opts("Open: Vertical Split") },
    { keys = "<C-h>",          cmd = api.node.open.horizontal,           opts = opts("Open: Horizontal Split") },
    -- Mouse 鼠标键
    { keys = "<2-LeftMouse>",  cmd = api.node.open.edit,                 opts = opts("Open") },
    { keys = "<2-RightMouse>", cmd = api.tree.change_root_to_node,       opts = opts("CD") },
  }
end

return M
