-- <nixCats>/lsp/nil.lua
-- Nil LSP config

vim.lsp.config("nil", {
  cmd = { "nil" },
  root_markers = {
    "flake.nix",
    "flake.lock",
  },
  filetypes = {
    "nix",
  },
  -- Global config options
  settings = {
    ["nil"] = {
      formatting = {
        command = { "alejandra" },
      },
      diagnostics = {
        ignored = {},
      },
      nix = {
        maxMemoryMB = 2560,
      },
      flake = {
        autoArchive = false,
        autoEvalImputs = true,
        nixpkgsInputName = "nixpkgs",
      },
    },
  },
})
