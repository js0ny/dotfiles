{pkgs, ...}: {
  imports = [
    ./wayland-wm.nix
  ];
  programs.sway.enable = true;
  programs.sway.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    swaybg
    sway-contrib.grimshot
    waybar
    xdg-desktop-portal-wlr
  ];
}
