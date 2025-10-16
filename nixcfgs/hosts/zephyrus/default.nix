# ~/.config/nixcfgs/hosts/zephyrus/default.nix
{config, ...}: {
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
    ../../modules/nixos/desktop/gnome.nix
    ../../modules/nixos/desktop/niri.nix
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
  networking.modemmanager.enable = false;
  # Xilinx Artix-7 Basys 3
  services.udev.extraRules = ''
    ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0660", GROUP="dialout", SYMLINK+="basys3"
  '';
  system.stateVersion = "25.05";
}
