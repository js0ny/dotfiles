{
  config,
  pkgs,
  lib,
  ...
}: let
  term = "xdg-terminal-exec";
  # TODO: Don't default to dark
  iconTheme = config.my.desktop.style.iconTheme.dark;
  launcher = "walker";
  kbdBacklightDev = config.my.hardware.keyboardBacklight.device;
  kbdBacklightStep = config.my.hardware.keyboardBacklight.step;
  nirictl = import ./scripts.nix {inherit pkgs;};
in {
  home.packages = [
    nirictl.focusOrLaunch
  ];
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # === Application Runner ===
    "Mod+B".hotkey-overlay.title = "Focus or launch web browser";
    "Mod+B".action = spawn "${lib.getExe nirictl.focusOrLaunch}" "firefox" "firefox";
    "Mod+Shift+B".hotkey-overlay.title = "Launch web browser in private mode";
    "Mod+Shift+B".action = spawn "firefox" "--private-window";
    "Mod+A".action = spawn-sh "${term} --class=terminal-popup -e aichat --session";
    "Mod+Shift+A".hotkey-overlay.title = "Focus or launch CherryStudio (AI assistant)";
    "Mod+Shift+A".action = spawn "${lib.getExe nirictl.focusOrLaunch}" "CherryStudio" "cherry-studio";
    "Mod+O".hotkey-overlay.title = "Focus or launch Obsidian";
    "Mod+O".action = spawn "${lib.getExe nirictl.focusOrLaunch}" "obsidian" "obsidian";
    # See: programs/obsidian/obsidian-grep.nix
    "Mod+Shift+O".action = spawn-sh "${term} --app-id=terminal-popup -e obsidian-grep && ${lib.getExe nirictl.focusOrLaunch} obsidian obsidian";
    # TODO: Change "org.kde.dolphin" to a more generic explorer app id via config.currentUser
    "Mod+E".hotkey-overlay.title = "Launch file explorer";
    # "Mod+E".action = spawn "${lib.getExe nirictl.focusOrLaunch}" "org.kde.dolphin" "dolphin";
    "Mod+E".action = spawn-sh "xdg-open ~";
    "Mod+Shift+E".action = spawn "fsearch";
    "Mod+Shift+Return".action = spawn-sh "${term} --app-id=terminal-popup";
    # "Mod+Shift+Alt+Return".action = spawn-sh "${term} --app-id=kitty--terminal-popup --working-directory='${config.home.homeDirectory}/.config/shells/nohist' -e nix develop";

    "Mod+Alt+Return".action = spawn "neovide" "${config.home.homeDirectory}/Atelier";
    "Mod+Apostrophe".action =
      spawn-sh "EDITOR_MINIMAL=1 ${term} -o close_on_child_death=yes --app-id=terminal-popup -e edit-clipboard --minimal";

    "Mod+Shift+Slash".action = show-hotkey-overlay;

    "Mod+Return".hotkey-overlay.title = "Open a Terminal: ${term}";
    "Mod+Return".action = spawn "${term}";

    "Mod+Alt+i".hotkey-overlay.title = "Hyprlock";
    "Mod+Alt+i".action = spawn "hyprlock";

    "Alt+Space".hotkey-overlay.title = "Run an Application: ${launcher}";
    "Alt+Space".action =
      spawn "${launcher}";

    "Mod+W".hotkey-overlay.title = "Search open Window: ${launcher}";
    "Mod+W".action =
      spawn "${launcher}" "-m" "windows";

    "Mod+V".action =
      # spawn-sh "cliphist list | ${launcher} -dmenu | cliphist decode | wl-copy";
      spawn "${launcher}" "-m" "clipboard";

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

    "XF86MonBrightnessUp" = {
      action = spawn "brightnessctl" "set" "10%+";
      allow-when-locked = true;
    };

    "XF86MonBrightnessDown" = {
      action = spawn "brightnessctl" "set" "10%-";
      allow-when-locked = true;
    };

    "XF86AudioPrev".action = spawn "playerctl" "previous";
    "XF86AudioNext".action = spawn "playerctl" "next";
    "XF86AudioPlay".action = spawn "playerctl" "playpause";

    # NOTE: This is a host-specific config
    # G14 Built-in Fn+Enter
    "XF86Calculator".action = spawn "";
    # INFO: Seems that niri does not support touchpad toggle, waiting for upstream implementation.
    "XF86TouchpadToggle".action = spawn "";
    # TODO: Write logic for default case
    "XF86KbdBrightnessUp".action = spawn "brightnessctl" "--device" "${kbdBacklightDev}" "set" "${kbdBacklightStep}+";
    "XF86KbdBrightnessDown".action = spawn "brightnessctl" "--device" "${kbdBacklightDev}" "set" "${kbdBacklightStep}-";

    # NOTE: This is a host-specific config
    # G14 Power Profiles Switcher
    # ROG Key: XF86Launch1
    # AURA Key: XF86Launch3
    # Fan Key: XF86Launch4
    "XF86Launch4".action = spawn "powerprofiles-next"; # See ../packages.nix
    "XF86Launch1".action =
      spawn "${launcher}" "-show" "drun" "-icon-theme" "${iconTheme}" "-show-icons";

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

    "Mod+1".action = focus-workspace "1-master";
    "Mod+2".action = focus-workspace "2-project";
    "Mod+3".action = focus-workspace "3-alt";
    "Mod+4".action = focus-workspace "4-info";
    "Mod+5".action = focus-workspace "5-bg";
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;
    "Mod+Shift+1".action.move-column-to-workspace = "1-master";
    "Mod+Shift+2".action.move-column-to-workspace = "2-project";
    "Mod+Shift+3".action.move-column-to-workspace = "3-alt";
    "Mod+Shift+4".action.move-column-to-workspace = "4-info";
    "Mod+Shift+5".action.move-column-to-workspace = "5-bg";
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;

    "Mod+BracketLeft".action = consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;

    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;
    "Mod+M".action = maximize-column;
    "Mod+Shift+M".action = fullscreen-window;
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    "Mod+C".action = center-column;
    "Mod+Ctrl+C".action = center-visible-columns;
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";
    "Mod+F".action = toggle-window-floating;
    "Mod+Shift+F".action = switch-focus-between-floating-and-tiling;
    "Mod+G".hotkey-overlay.title = "Toggle Grouped Display";
    "Mod+G".action = toggle-column-tabbed-display;

    "Mod+Shift+S".action.screenshot = {show-pointer = true;};
    "Print".action.screenshot = {show-pointer = true;};
    "Ctrl+Print".action.screenshot-screen = {show-pointer = true;};
    "Mod+Alt+S".action.screenshot-screen = {show-pointer = true;};
    "Alt+Print".action.screenshot-window = {write-to-disk = true;};
    "Mod+S".action.screenshot-window = {write-to-disk = true;};

    "Mod+Escape".allow-inhibiting = false;
    "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;

    "Mod+Grave".action = focus-workspace-previous;

    "Ctrl+Alt+Delete".action = quit;
  };
}
