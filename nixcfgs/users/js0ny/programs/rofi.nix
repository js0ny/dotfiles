{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi
    rofimoji
    rofi-power-menu
  ];
}
