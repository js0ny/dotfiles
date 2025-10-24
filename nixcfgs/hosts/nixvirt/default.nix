# ~/.config/nixcfgs/hosts/nixvirt/default.nix
{
  config,
  lib,
  pkgs,
  nix-flatpak,
  ...
}: {
  imports = [
    # impure build
    /etc/nixos/hardware-configuration.nix
    ../../modules/nixos
    # ../../modules/nixos/users/js0ny.nix
    # ../../modules/nixos/guest.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/desktop/gnome.nix
    # ../../modules/nixos/desktop/niri.nix
    ../../modules/nixos/desktop/gnome.nix
    ../../modules/nixos/display-manager/gdm.nix
  ];
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "nixvirt";
  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "25.05";
}
