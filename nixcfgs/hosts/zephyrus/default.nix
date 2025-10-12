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
    # ../../modules/nixos/users/js0ny.nix
    # ../../modules/nixos/guest.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/disable-nvidia.nix
    ../../modules/nixos/additional-packages.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/desktop/gnome.nix
    # ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/display-manager/sddm.nix
    ./hardware-configuration.nix
    ./keyd.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zephyrus";
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "25.05";
}
