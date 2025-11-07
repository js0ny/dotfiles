{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./packages.nix
  ];
  home.file."${config.xdg.configHome}/niri/config.kdl" = {
    text = ''
      spawn-at-startup "waybar" // Status Bar
      spawn-at-startup "dunst" // Notifications
      spawn-at-startup "fcitx5" // Input Method
      spawn-at-startup "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"

      screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
      prefer-no-csd // client-side decorations (window decorations)

      input {
        keyboard {
            xkb {}
            numlock
        }
        touchpad {
            tap
            naturalscroll
        }
        mouse {}
        trackpoint {}
      }
    '';
    enable = false; # TODO:
  };
}
