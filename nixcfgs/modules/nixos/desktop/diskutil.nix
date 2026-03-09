{pkgs, ...}: {
  # udisks2 is needed for disk management and mounting.
  # If you cannot see external drives in your file manager, enable this.
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
  environment.systemPackages = [
    pkgs.smartmontools
  ];
  # davfs2 is for WebDAV mounts.
  services.davfs2.enable = true;
}
