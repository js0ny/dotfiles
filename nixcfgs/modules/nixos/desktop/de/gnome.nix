{pkgs, ...}: {
  services.desktopManager.gnome = {
    enable = true;
    sessionPath = with pkgs; [
      gtop
      gnome-menus
      gobject-introspection
      # Copyous
      libgda6
      gsound
    ];
  };
  environment.systemPackages = with pkgs; [
    gnome-menus
    gobject-introspection
  ];
  environment.gnome.excludePackages = with pkgs; [
    # LibAdwaita sucks
    evince # Document Viewer (Legacy)
    totem # GNOME Videos (legacy)
    papers # Document Viewer
    gnome-tour
    baobab # Disk Usage Analyzer, use dust instead
    epiphany # GNOME Web
    gnome-system-monitor # use mission-center
    gnome-terminal
    showtime # Media player
    gnome-music
    gnome-connections
    gnome-font-viewer
    gnome-maps
  ];
}
