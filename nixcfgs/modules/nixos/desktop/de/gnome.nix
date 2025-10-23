{ pkgs, ... }:
{
  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-menus
  ];
  environment.gnome.excludePackages = with pkgs; [
    evince
    totem
    papers
  ];
}
