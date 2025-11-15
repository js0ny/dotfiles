# ~/.dotfiles/nixcfgs/flake.nix
{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs-stable.url = "github:nixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    # flake-utils.url = "github:numtide/flake-utils";
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
    # caelestia-shell - shell for wms
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # sops - Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Niri - Wayland Window Manager
    niri-flake.url = "github:sodiboo/niri-flake";
    # xremap - kay remapper like keyd
    xremap-flake.url = "github:xremap/nix-flake";
    # betterfox - preconfigured firefox user.js
    betterfox-nix.url = "github:HeitorAugustoLN/betterfox-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    nix-flatpak,
    nix-darwin,
    home-manager,
    plasma-manager,
    nur,
    caelestia-shell,
    sops-nix,
    niri-flake,
    xremap-flake,
    betterfox-nix,
    ...
  } @ inputs: let
    overlays = [
      nur.overlays.default
      (final: prev: {
        caelestia-shell = caelestia-shell.packages.x86_64-linux.caelestia-shell;
      })
    ];
    forSystem = system:
      import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
    specialArgs = {inherit inputs overlays;};
    nixosHosts = [
      "zp"
      "zephyrus"
      "nixvirt"
      "polder"
    ];

    mkNixosSystem = hostname:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          xremap-flake.nixosModules.default
          sops-nix.nixosModules.sops
          ./hosts/${hostname}
          {nixpkgs.overlays = overlays;}
        ];
      };
  in {
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
          sops-nix.homeManagerModules.sops
          niri-flake.homeModules.niri
          betterfox-nix.modules.homeManager.betterfox
        ];
      };
      "js0ny@nixvirt" = home-manager.lib.homeManagerConfiguration {
        pkgs = forSystem "x86_64-linux";
        extraSpecialArgs = specialArgs;
        modules = [
          ./users/js0ny/nixvirt.nix
        ];
      };
      "js0ny@polder" = home-manager.lib.homeManagerConfiguration {
        pkgs = forSystem "x86_64-linux";
        extraSpecialArgs = specialArgs;
        modules = [
          ./users/js0ny/polder.nix
        ];
      };
      "js0ny@zen" = home-manager.lib.homeManagerConfiguration {
        pkgs = forSystem "aarch64-darwin";
        extraSpecialArgs = specialArgs;
        modules = [
          ./users/js0ny/zen.nix
        ];
      };
    };
  };
}
