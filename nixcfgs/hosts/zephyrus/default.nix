# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{
  config,
  lib,
  pkgs,
  nix-flatpak,
  ...
}:
{
  imports = [
    ../../modules/nixos
    ../../modules/nixos/host-machine.nix
    # ../../modules/nixos/users/js0ny.nix
    # ../../modules/nixos/guest.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/nvidia.nix
    ../../modules/nixos/additional-packages.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/chromium.nix
    ../../modules/nixos/obs-studio.nix
    ../../modules/nixos/wine.nix
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
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=2 card_label="OBS Virtual Camera" exclusive_caps=1
  '';
  system.stateVersion = "25.05";
}
