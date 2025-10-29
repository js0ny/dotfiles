-- Lua
--[[ Installation
scoop install lua-language-server
brew install lua-language-server
sudo port install lua-language-server
--]]
--[[ Build: Ninja & C++17 Required
git clone https://github.com/LuaLS/lua-language-server --depth 1
cd lua-language-server
./make.sh
--]]
--[[ Note: For building from source, wrapper script is required
Accompanied with a wrapper script
#!/bin/bash
exec "$HOME/.local/build/lua-language-server/bin/lua-language-server" "$@"
--]]
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  on_init = function(client)
    local path = client.workspace_folders and client.workspace_folders[1] and client.workspace_folders[1].name
    if path and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
      return
    end
    client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/luv/library",
          },
        },
      },
    })
  end,
  settings = {
    Lua = {
      -- Inlay hints
      hint = {
        enable = true,
        setType = true,
        arrayIndex = "Disable",
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
        postfix = ".",
        displayContext = 50,
      },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim" },
      },
      -- Lua LS offers a code formatter
      -- Ref: https://github.com/LuaLS/lua-language-server/wiki/Formatter
      -- format = {
      --     enable = true,
      --     defaultConfig = {
      --         indent_size = "4",
      --         max_line_length = "100",
      --         continuation_indent = "8",
      --     },
      -- },
      -- diagnostics = {
      --     -- Code style checking offered by the Lua LS code formatter
      --     neededFileStatus = {
      --         ["codestyle-check"] = "Any",
      --     },
      -- },
    },
  },
}
