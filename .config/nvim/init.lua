-- bootstrap lazy.nvim, LazyVim and your plugins
if (vim.g.vscode) then
  print("VSCode detected, skipping lazy loading")
  require("vscode.code")
else
  require("config.lazy")
  -- require("config.lazy")
end
