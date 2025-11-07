{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    pavucontrol
    font-awesome
  ];
}
