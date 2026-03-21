{
  pkgs,
  inputs,
  ...
}:
let
  mkNixPak = inputs.nixpak.lib.nixpak {
    inherit (pkgs) lib;
    inherit pkgs;
  };
in
{
  # Expose sandboxed app(s) through nixpkgs overlay.
  nixpkgs.overlays = [
    (_: prev: {
      nixpaks.qq = prev.callPackage ./qq.nix {
        inherit mkNixPak;
      };
    })
  ];
}
