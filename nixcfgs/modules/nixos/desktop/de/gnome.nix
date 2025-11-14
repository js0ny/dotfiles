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
    evince
    totem
    papers
    gtop
  ];
  services.xremap.withGnome = true;
}
