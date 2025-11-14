{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # caelestia-shell
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    xdg-desktop-portal-wlr
  ];
  services.xremap.withHypr = true;
}
