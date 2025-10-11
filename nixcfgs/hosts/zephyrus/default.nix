# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{
  config,
  lib,
  pkgs,
  nix-flatpak,
  ...
}: {
  imports = [
    ../../modules/nixos
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/disable-nvidia.nix
    ../../modules/nixos/additional-packages.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/desktop/gnome.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/display-manager/ly.nix
    ./hardware-configuration.nix
    ./keyd.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zephyrus";
  system.stateVersion = "25.05";
}
