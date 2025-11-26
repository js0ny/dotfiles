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
    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord.url = "github:kaylorben/nixcord";
    catppuccin.url = "github:catppuccin/nix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
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
    firefox-addons,
    zen-browser,
    nixcord,
    catppuccin,
    nix-index-database,
    walker,
    ...
  } @ inputs: let
    overlays = [
      nur.overlays.default
      firefox-addons.overlays.default
      (final: prev: {
        caelestia-shell = caelestia-shell.packages.x86_64-linux.caelestia-shell;
      })
      (final: pref: {
        zen-browser = zen-browser.packages.x86_64-linux.zen-browser;
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
    darwinHosts = [
      "zen"
    ];

    mkNixosSystem = hostname:
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;
        modules = [
          xremap-flake.nixosModules.default
          sops-nix.nixosModules.sops
          catppuccin.nixosModules.catppuccin
          ./hosts/${hostname}
          {nixpkgs.overlays = overlays;}
        ];
      };
    mkDarwinSystem = hostname:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        inherit specialArgs;
        modules = [
          ./hosts/${hostname}
          {nixpkgs.overlays = overlays;}
        ];
      };
  in {
    # This will automatically generate nixOS config for `nixosHosts'
    # Include the module ./hosts/${hostname} by default.
    nixosConfigurations = nixpkgs.lib.genAttrs nixosHosts mkNixosSystem;
    darwinConfigurations = nixpkgs.lib.genAttrs darwinHosts mkDarwinSystem;

    homeConfigurations = {
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
          nixcord.homeModules.nixcord
          catppuccin.homeModules.catppuccin
          nix-index-database.homeModules.nix-index
          walker.homeManagerModules.default
        ];
      };
      "js0ny@zen" = home-manager.lib.homeManagerConfiguration {
        pkgs = forSystem "aarch64-darwin";
        extraSpecialArgs = specialArgs;
        modules = [
          ./users/js0ny/zen.nix
          catppuccin.homeModules.catppuccin
          betterfox-nix.modules.homeManager.betterfox
          sops-nix.homeManagerModules.sops
        ];
      };
    };
    # Export nixos modules for private use
    nixosModules = {
      server = {...}: {
        imports = [
          ./modules/nixos
          ./modules/nixos/server.nix
          ./modules/nixos/core/sshd.nix
          ./modules/nixos/programs/zsh.nix
        ];
      };
    };
  };
}
