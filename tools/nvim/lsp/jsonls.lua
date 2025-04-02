-- JSON
--[[
npm i vscode-json-languageserver
--]]
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  init_options = {
    provideFormatter = true,
  },
  settings = {
    -- See setting options
    -- https://github.com/microsoft/vscode/tree/main/extensions/json-language-features/server#settings
    json = {
    },
  },
}
