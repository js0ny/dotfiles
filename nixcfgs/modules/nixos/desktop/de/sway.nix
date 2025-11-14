{pkgs, ...}: {
  programs.sway.enable = true;
  programs.sway.xwayland.enable = true;
  services.xremap.withWlroots = true;
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
