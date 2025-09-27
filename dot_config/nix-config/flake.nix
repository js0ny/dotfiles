{
  description = "My macOS Flake config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, ... }: {
    darwinConfigurations."zen" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/macbook/default.nix
        ./hosts/macbook/brew.nix
        ./hosts/macbook/system.nix
      ];
    };
    
  };
}
