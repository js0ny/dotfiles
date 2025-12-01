{pkgs, ...}: {
  imports = [
    ../packages.nix
    ./window-rules.nix
    ./keymaps.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      workspaces = {
        "1-master" = {};
        "2-project" = {};
        "3-alt" = {};
        "4-info" = {};
        "5-bg" = {};
      };

      spawn-at-startup = [
        {argv = ["fcitx5"];}
        {argv = ["swww-daemon"];}
        # polkit/portal helpers
        # {argv = ["${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"];}
      ];

      input = {
        keyboard = {
          xkb = {};
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
          disabled-on-external-mouse = false;
          dwt = true; # disable on typing
        };

        mouse = {};
        trackpoint = {};
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];

        default-column-width = {proportion = 0.5;};

        focus-ring = {
          enable = true;
          width = 4;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };

        border = {
          enable = false;
          width = 4;
          active.color = "#ffc87f";
          inactive.color = "#505050";
          urgent.color = "#9b0000";
        };

        shadow = {
          enable = false;
          softness = 30;
          spread = 5;
          offset = {
            x = 0;
            y = 5;
          };
          color = "#0007";
        };
      };
    };
  };
}
