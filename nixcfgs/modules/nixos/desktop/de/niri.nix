{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    mako
    rofi
    rofimoji
    rofi-power-menu
    swaylock-effects
    xwayland-satellite
    wmname
  ];
}
