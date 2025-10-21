{pkgs, ...}: {
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    mako
    rofi
  ];
}
