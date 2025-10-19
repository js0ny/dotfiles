{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  environment.systemPackages = [
    inputs.caelestia-shell.packages.x86_64-linux.default
    pkgs.mako
    pkgs.rofi-wayland
    pkgs.xdg-desktop-portal-wlr
    pkgs.xdg-desktop-portal-hyprland
    pkgs.hyprpolkitagent
    pkgs.cliphist
    pkgs.grimblast
  ];
}
