{pkgs, ...}: let
  swayidleWrapper = pkgs.writeShellScriptBin "swayidle-wrapper" ''
    ${pkgs.swayidle}/bin/swayidle -w \
             timeout 300 'swaylock -f' \
             timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
             before-sleep 'swaylock -f -c 000000'
  '';
in {
  imports = [
    ../../rofi.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    swayidle # Screensaver
    dunst # Notification daemon
    cliphist # Clipboard daemon
    swww # Wallpaper daemon
    wmname
    swayidleWrapper
  ];
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };
}
