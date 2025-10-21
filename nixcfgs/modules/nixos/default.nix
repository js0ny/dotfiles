{pkgs, ...}: {
  imports = [
    ./core/configuration.nix
    ./core/packages.nix
  ];
}

