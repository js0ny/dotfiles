{lib, ...}: {
  imports = [
    ../../modules/nixos
    ../../modules/nixos/programs/zsh.nix
  ];

  networking.hostName = "zp";

  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  fileSystems."/" = lib.mkDefault {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  system.stateVersion = "25.05";
}
