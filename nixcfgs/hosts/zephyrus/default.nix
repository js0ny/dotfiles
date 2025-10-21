# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{...}: {
  imports = [
    ../../modules/nixos
    ../../modules/nixos/host-machine.nix
    ../../modules/nixos/waydroid.nix
    ../../modules/nixos/laptop.nix
    ../../modules/nixos/disable-nvidia.nix
    ../../modules/nixos/additional-packages.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/chromium.nix
    ../../modules/nixos/obs-studio.nix
    ../../modules/nixos/wine.nix
    ../../modules/nixos/exp.nix
    ../../modules/nixos/gnome-keyring.nix
    ../../modules/nixos/udev/basys3.nix
    ../../modules/nixos/desktop/kde.nix
    ../../modules/nixos/desktop/hyprland.nix
    ../../modules/nixos/display-manager/sddm.nix
    ./hardware-configuration.nix
    ./keyd.nix
    ./packages.nix
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "zephyrus";
  networking.modemmanager.enable = false;
  system.stateVersion = "25.05";
}
