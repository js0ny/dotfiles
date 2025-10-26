# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{pkgs, ...}: {
  imports = [
    # Host-specific configs
    ./asus.nix
    ./hardware-configuration.nix
    ./keyd.nix

    # core config and packages
    ../../modules/nixos

    # this is a laptop
    ../../modules/nixos/desktop
    ../../modules/nixos/desktop/laptop.nix

    # hardware drivers
    ../../modules/nixos/hardware/nvidia.nix

    # udev rules
    ../../modules/nixos/hardware/udev/basys3.nix

    # desktop environment and display manager
    ../../modules/nixos/desktop/dm/sddm.nix
    ../../modules/nixos/desktop/de/kde.nix
    ../../modules/nixos/desktop/de/niri.nix

    # desktop programs
    ../../modules/nixos/programs/chromium.nix
    ../../modules/nixos/programs/firefox.nix
    ../../modules/nixos/programs/libvirt.nix
    ../../modules/nixos/programs/obs-studio.nix
    ../../modules/nixos/programs/rime.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/programs/waydroid.nix
    ../../modules/nixos/programs/winboat.nix
    ../../modules/nixos/programs/wine.nix

    # services
    ../../modules/nixos/services/docker.nix
    ../../modules/nixos/services/exp.nix
  ];

  # Hostname
  networking.hostName = "zephyrus";

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use unfree software
  nixpkgs.config.allowUnfree = true;

  # Disable modem
  networking.modemmanager.enable = false;
  services.flatpak.enable = true;
  system.stateVersion = "25.05";
}
