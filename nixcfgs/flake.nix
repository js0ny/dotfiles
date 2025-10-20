# ~/.dotfiles/nixcfgs/flake.nix
{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    flake-utils.url = "github:numtide/flake-utils";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nur.url = "github:nix-community/NUR";
    winboat.url = "github:TibixDev/winboat";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      nix-darwin,
      home-manager,
      plasma-manager,
      nur,
      winboat,
      caelestia-shell,
      ...
    }@inputs:
    let
      overlays = [
        nur.overlays.default
        (final: prev: {
          winboat = winboat.packages.x86_64-linux.winboat;
        })
      ];
      forSystem =
        system:
        import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
      specialArgs = { inherit inputs; };
      nixosHosts = [
        "zp"
        "zephyrus"
        "nixvirt"
      ];

      mkNixosSystem =
        hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;
          modules = [ ./hosts/${hostname} ];
        };
    in
    {
      # This will automatically generate nixOS config for `nixosHosts'
      # Include the module ./hosts/${hostname} by default.
      nixosConfigurations = nixpkgs.lib.genAttrs nixosHosts mkNixosSystem;

      darwinConfigurations."zen" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        inherit specialArgs;
        modules = [
          ./hosts/zen
        ];
      };

      homeConfigurations = {
        js0ny = home-manager.lib.homeManagerConfiguration {
          pkgs = forSystem "x86_64-linux";
          extraSpecialArgs = specialArgs;
          modules = [
            ./users/js0ny
          ];
        };
        "js0ny@zephyrus" = home-manager.lib.homeManagerConfiguration {
          pkgs = forSystem "x86_64-linux";
          extraSpecialArgs = specialArgs;
          modules = [
            ./users/js0ny/zephyrus.nix
            plasma-manager.homeModules.plasma-manager
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };
        "js0ny@nixvirt" = home-manager.lib.homeManagerConfiguration {
          pkgs = forSystem "x86_64-linux";
          extraSpecialArgs = specialArgs;
          modules = [
            ./users/js0ny/nixvirt.nix
          ];
        };
      };
    };
}
