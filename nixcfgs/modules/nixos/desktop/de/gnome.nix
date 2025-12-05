{pkgs, ...}: {
  services.desktopManager.gnome = {
    enable = true;
    sessionPath = [pkgs.gtop];
  };
  environment.systemPackages = with pkgs; [
    gnome-menus
    gobject-introspection
  ];
  environment.gnome.excludePackages = with pkgs; [
    evince # Document Viewer (Legacy)
    totem # GNOME Videos (legacy)
    papers # Document Viewer
    tour
    baobab # Disk Usage Analyzer, use dust instead
    epiphany # GNOME Web
  ];
}
