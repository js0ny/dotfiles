--- Available LSP goes here
--- Check https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--- for available server and name
local servers = {
    "arduino_language_server", -- Arduino
    "bashls",                  -- Bash
    "clangd",                  -- C/C++
    "cmake",                   -- CMake
    "eslint",                  -- JavaScript
    "gopls",                   -- Go
    "html",                    -- HTML
    "julials",                 -- Julia
    "lua_ls",                  -- Lua
    "omnisharp",               -- C# & F#
    "powershell_es",           -- PowerShell
    "pyright",                 -- Python
    "rust_analyzer",           -- Rust
    "taplo",                   -- TOML
    "vimls",                   -- vimscript
}

return servers
