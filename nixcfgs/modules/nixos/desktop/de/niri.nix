{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    dunst
    rofi
    rofimoji
    rofi-power-menu
    swaylock-effects
    swayidle
    xwayland-satellite
    wmname
    hyprpolkitagent
  ];
  fonts.packages = [pkgs.font-awesome];
  xdg.portal = {
    extraPortals = with pkgs; [
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = ["kde" "wlr"];
  };
}
