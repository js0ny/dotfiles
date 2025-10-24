{ pkgs, ... }:
{
  home.packages = with pkgs.gnomeExtensions; [
    paperwm
  ];
  programs.gnome-shell.extensions = [
    { package = pkgs.gnomeExtensions.paperwm; }
  ];
}
