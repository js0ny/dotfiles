{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    caelestia-shell
    mako
    rofi
    xdg-desktop-portal-wlr
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    cliphist
    grimblast
  ];
}
