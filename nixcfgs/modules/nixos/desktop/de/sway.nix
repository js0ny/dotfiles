{pkgs, ...}: {
  programs.sway.enable = true;
  programs.sway.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    dunst
    rofi
    rofimoji
    rofi-power-menu
    swaylock-effects
    sway-contrib.grimshot
    waybar
  ];
}
