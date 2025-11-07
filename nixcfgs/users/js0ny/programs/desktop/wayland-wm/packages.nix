{pkgs, ...}: {
  imports = [
    ../../rofi.nix
    ./waybar.nix
  ];
  home.packages = with pkgs; [
    swayidle # Screensaver
    dunst # Notification daemon
    swaylock-effects # Screensaver
    cliphist # Clipboard daemon
    swww # Wallpaper daemon
    wmname
  ];
}
