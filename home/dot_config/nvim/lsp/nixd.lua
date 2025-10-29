---@type vim.lsp.Config
return {
  cmd = { "nixd" },
  root_markers = { "flake.nix", "flake.lock" },
  filetypes = { "nix" },
  settings = {
    nixpkgs = {
      expr = "import <nixpkgs> { }",
    },
    formatting = {
      command = { "alejandra" },
    },
    options = {
      nixos = {
        expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.zephyrus.options',
      },
      home_manager = {
        expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."js0ny@zephyrus".options',
      },
    },
  },
}
