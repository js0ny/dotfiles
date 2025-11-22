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
    ../../modules/nixos/hardware/nvidia/nvidia-disable.nix

    # udev rules
    ../../modules/nixos/hardware/udev/basys3.nix

    # Services
    ../../modules/nixos/desktop/wayvnc.nix
    ../../modules/nixos/core/sshd.nix
    ../../modules/nixos/desktop/xremap.nix

    # desktop environment and display manager
    ../../modules/nixos/desktop/dm/ly.nix
    ../../modules/nixos/desktop/de/niri.nix
    ../../modules/nixos/desktop/de/hyprland.nix

    # desktop programs
    ../../modules/nixos/programs/zsh.nix
    ../../modules/nixos/programs/chromium.nix
    ../../modules/nixos/programs/firefox.nix
    ../../modules/nixos/programs/libvirt.nix
    ../../modules/nixos/programs/obs-studio.nix
    ../../modules/nixos/programs/rime.nix
    ../../modules/nixos/programs/steam.nix
    ../../modules/nixos/programs/thunderbird.nix
    ../../modules/nixos/programs/waydroid.nix
    ../../modules/nixos/programs/wine.nix
    ../../modules/nixos/programs/dolphin.nix

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

  zramSwap = {
    enable = true;
    memoryPercent = 10;
    algorithm = "lz4";
    priority = 100;
  };

  # Disable modem
  networking.modemmanager.enable = false;
  services.flatpak.enable = true;
  system.stateVersion = "25.05";
}
