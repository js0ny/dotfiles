# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{...}: {
  imports = [
    ../../modules/nixos
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/exp.nix
    ../../modules/nixos/desktop/host-machine.nix
    ../../modules/nixos/desktop/laptop.nix
    ../../modules/nixos/desktop/disable-nvidia.nix
    ../../modules/nixos/additional-packages.nix
    ../../modules/nixos/desktop
    ../../modules/nixos/desktop/firefox.nix
    ../../modules/nixos/desktop/steam.nix
    ../../modules/nixos/desktop/chromium.nix
    ../../modules/nixos/desktop/obs-studio.nix
    ../../modules/nixos/desktop/wine.nix
    ../../modules/nixos/desktop/gnome-keyring.nix
    ../../modules/nixos/udev/basys3.nix
    ../../modules/nixos/desktop-environment/kde.nix
    ../../modules/nixos/desktop-environment/hyprland.nix
    ../../modules/nixos/display-manager/sddm.nix
    ./hardware-configuration.nix
    ./keyd.nix
    ./packages.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zephyrus";
  networking.modemmanager.enable = false;
  system.stateVersion = "25.05";
}
