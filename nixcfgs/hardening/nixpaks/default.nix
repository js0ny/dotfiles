{
  pkgs,
  inputs,
  ...
}: let
  mkNixPak = inputs.nixpak.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };

  callNixPak = path:
    pkgs.callPackage path {
      inherit mkNixPak;
    };
in {
  nixpkgs.overlays = [
    (_: prev: {
      nixpaks = {
        qq = callNixPak ./qq.nix;
        termius = callNixPak ./termius.nix;
        zoom-us = callNixPak ./zoom-us.nix;
      };
    })
  ];
}
