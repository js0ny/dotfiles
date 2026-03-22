{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools =
    import ../../../../modules/lib/mergetools.nix
    {inherit pkgs lib config;};
  mkMergedIni = mergetools.mkMergedIni;
  # https://wiki.archlinux.org/title/Zoom_Meetings#Running_on_Wayland_without_Xwayland
  zoomUsConfig = mkMergedIni {
    name = "zoomusConfig";
    target = "${config.home.homeDirectory}/.var/app/us.zoom.Zoom/config/zoomus.conf";
    settings = {
      General = {
        xwayland = false;
      };
    };
  };
in {
  imports = [
    zoomUsConfig
    ../../../../hardening/nixpaks
  ];

  home.packages = with pkgs; [
    nixpaks.zoom-us
  ];
}
