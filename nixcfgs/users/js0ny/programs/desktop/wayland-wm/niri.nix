{
  config,
  pkgs,
  ...
}: {
  home.file."${config.xdg.configHome}/niri/config.kdl" = {
    text = ''
      spawn-at-startup "waybar" // Status Bar
      spawn-at-startup "dunst" // Notifications
      spawn-at-startup "fcitx5" // Input Method
      spawn-at-startup "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
      spawn-at-startup
      input {
        xkb {}
        numlock
        touchpad {
            tap
            naturalscroll
        }
        mouse {}
      }
    '';
    enable = false; # TODO:
  };
}
