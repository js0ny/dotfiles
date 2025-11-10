{
  config,
  pkgs,
  ...
}: let
  term = config.currentUser.defaultTerminal;
  termRunner = config.currentUser.defaultTerminalRunner;
  iconTheme = config.currentUser.iconTheme;
  explorer = config.currentUser.defaultExplorer;
  explorerTerm = config.currentUser.defaultTerminalExplorer;
  launcher = "rofi";
in {
  imports = [
    ./packages.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

      spawn-at-startup = [
        {argv = ["waybar"];}
        {argv = ["dunst"];}
        {argv = ["fcitx5"];}
        # polkit/portal helpers
        {argv = ["${pkgs.kdePackages.xdg-desktop-portal-kde}/libexec/xdg-desktop-portal-kde"];}
        {argv = ["${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"];}
      ];

      input = {
        keyboard = {
          xkb = {};
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
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

      window-rules = [
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
            # Anki add new flashcard
            {
              app-id = "^anki$";
              title = "^Add$";
            }
            # Dolphin compressing files
            {
              app-id = "^org.kde.dolphin$";
              title = "^Compressing.*$";
            }
            {
              app-id = "^thunar$";
              title = "^File Operation Progress$";
            }
            ### IM Medias
            {
              app-id = "^QQ$";
              title = "^图片查看器$";
            }
            {
              app-id = "^org.telegram.desktop$";
              title = "^Media viewer$";
            }
            {
              app-id = "^wechat$";
              title = "^图片和视频$";
            }
            {
              app-id = "^org.pulseaudio.pavucontrol$";
              title = "^Volume Control$";
            }
          ];
          open-floating = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+Return".hotkey-overlay.title = "Open a Terminal: ${term}";
        "Mod+Return".action = spawn "${term}";

        "Mod+D".hotkey-overlay.title = "Run an Application: rofi";
        "Mod+D".action =
          spawn "${launcher}" "-show" "drun" "-icon-theme" "${iconTheme}" "-show-icons";

        "Alt+Space".hotkey-overlay.title = "Run an Application: rofi";
        "Alt+Space".action =
          spawn "${launcher}" "-show" "drun" "-icon-theme" "${iconTheme}" "-show-icons";

        "Mod+Shift+W".hotkey-overlay.title = "Search open Window: rofi";
        "Mod+Shift+W".action =
          spawn "${launcher}" "-show" "window" "-icon-theme" "${iconTheme}" "-show-icons";

        "Mod+E".hotkey-overlay.title = "Run file explorer";
        "Mod+E".action = spawn "${explorer}";
        "Mod+Shift+E".hotkey-overlay.title = "Run terminal explorer";
        "Mod+Shift+E".action = spawn "${termRunner}" "${explorerTerm}";

        "XF86AudioRaiseVolume".allow-when-locked = true;
        "XF86AudioRaiseVolume".action =
          spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+";
        "XF86AudioLowerVolume".allow-when-locked = true;
        "XF86AudioLowerVolume".action =
          spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
        "XF86AudioMute".allow-when-locked = true;
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        "XF86AudioMicMute".allow-when-locked = true;
        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

        "Mod+Tab".action = toggle-overview;
        "Mod+Q".action = close-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Alt+Left".action = focus-monitor-left;
        "Mod+Alt+Down".action = focus-monitor-down;
        "Mod+Alt+Up".action = focus-monitor-up;
        "Mod+Alt+Right".action = focus-monitor-right;
        "Mod+Alt+H".action = focus-monitor-left;
        "Mod+Alt+J".action = focus-monitor-down;
        "Mod+Alt+K".action = focus-monitor-up;
        "Mod+Alt+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+WheelScrollDown".cooldown-ms = 150;
        "Mod+WheelScrollDown".action = focus-workspace-down;
        "Mod+WheelScrollUp".cooldown-ms = 150;
        "Mod+WheelScrollUp".action = focus-workspace-up;
        "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
        "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;
        "Mod+F".action = maximize-column;
        "Mod+Shift+M".action = fullscreen-window;
        "Mod+Ctrl+F".action = expand-column-to-available-width;
        "Mod+C".action = center-column;
        "Mod+Ctrl+C".action = center-visible-columns;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";
        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";
        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
        "Mod+W".action = toggle-column-tabbed-display;

        "Mod+Shift+S".action.screenshot = {show-pointer = true;};
        "Print".action.screenshot = {show-pointer = true;};
        # "Ctrl+Print".action.screenshot-screen  = {true};
        "Alt+Print".action.screenshot-window = {write-to-disk = true;};

        "Mod+Escape".allow-inhibiting = false;
        "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

        "Ctrl+Alt+Delete".action = quit;
      };
    };
  };
}
