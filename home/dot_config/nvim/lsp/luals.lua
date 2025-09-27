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
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
  },
  filetypes = { "lua" },
  settings = {
    Lua = {
      hint = {
        enable = true,
        setType = true,
      },
    },
  },
}
