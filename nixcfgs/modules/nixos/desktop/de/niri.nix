{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    dunst
    rofi
    rofimoji
    rofi-power-menu
    swaylock-effects
    xwayland-satellite
    wmname
  ];
}
