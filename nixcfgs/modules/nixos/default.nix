{pkgs, ...}: {
  imports = [
    ./configuration.nix
    ./packages.nix
    ./fonts.nix
  ];
}
