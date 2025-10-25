{pkgs, ...}: {
  programs.sway.enable = true;
  programs.sway.xwayland.enable = true;
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    mako
    rofi
    rofimoji
    rofi-power-menu
    swaylock-effects
    sway-contrib.grimshot
    waybar
  ];
}
