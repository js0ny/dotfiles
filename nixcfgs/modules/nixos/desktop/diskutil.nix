{pkgs, ...}: {
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
  environment.systempackages = [
    pkgs.smartmontools
  ];
}
