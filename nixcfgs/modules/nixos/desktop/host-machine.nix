{pkgs, ...}: {
  imports = [
    ./xremap.nix
    ./diskutil.nix
  ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    v4l-utils
    f2fs-tools
    openvpn
  ];

  programs.gpu-screen-recorder.enable = true;
}
