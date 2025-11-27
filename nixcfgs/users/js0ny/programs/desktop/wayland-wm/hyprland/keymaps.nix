{
  config,
  pkgs,
  lib,
  ...
}: let
  term = config.currentUser.defaultTerminal;
  termRunner = config.currentUser.defaultTerminalRunner;
  iconTheme = config.currentUser.iconTheme;
  explorer = config.currentUser.defaultExplorer;
  explorerTerm = config.currentUser.defaultTerminalExplorer;
  launcher = "walker";
  kbdBacklightDev = config.currentHost.keyboardBacklightDevice;
  kbdBacklightStep = config.currentHost.keyboardBacklightStep;
  mainMod = "SUPER";
  screenshotPath = "$HOME/Pictures/Screenshots/\"$(%Y-%m-%d_%H-%M-%S.png)\"";
  my = import ./scripts.nix {inherit pkgs;};
  resizeStep = builtins.toString 20;
in {
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "${mainMod}";
    bind = [
      # === Run Applications ===
      "$mainMod, return, exec, ${term}"
      "$mainMod SHIFT, return, exec, ${termRunner} --directory ~/Atelier -e nvim"
      "$mainMod, B, exec, ${lib.getExe my.launch-or-focus} firefox firefox"
      "$mainMod SHIFT, B, exec, firefox --private-window"
      "$mainMod, A, exec, kitty --class=kitty-terminal-popup -e aichat --session"
      "$mainMod SHIFT, A, exec, ${lib.getExe my.launch-or-focus} 'Cherry Studio' 'cherry-studio'"
      "$mainMod, T, exec, kitty --class=kitty-terminal-popup"
      "$mainMod SHIFT, T, exec, kitty --class=kitty-terminal-popup --working-directory='${config.home.homeDirectory}/.config/shells/nohist' -e nix develop"
      "$mainMod, O, exec, ${lib.getExe my.launch-or-focus} 'obsidian' 'obsidian'"
      "$mainMod, Q, killactive"
      ''$mainMod SHIFT, F, exec, hyprctl --batch "dispatch togglefloating ;  dispatch resizeactive exact 1440 810 ; dispatch centerwindow 1;"''
      "$mainMod SHIFT, M, fullscreen"
      "$mainMod, W, exec, ${launcher} -m windows"
      "$mainMod, Apostrophe, exec, EDITOR_MINIMAL=1 ${termRunner} -o close_on_child_death=yes --class=${termRunner}-terminal-popup -e edit-clipboard --minimal"
      "$mainMod, V, exec, ${launcher} -m clipboard"
      "alt, space, exec, ${launcher} -m desktopapplications"
      "$mainMod, E, exec, ${explorer}"
      "$mainMod SHIFT, E, exec, ${termRunner} -e ${explorerTerm}"
      "CTRL ALT, DELETE, exec, uwsm exit"
      "$mainMod, P, pseudo"
      "$mainMod, Y, togglesplit"
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, K, movefocus, u"
      "$mainMod, J, movefocus, d"
      "$mainMod SHIFT, H, swapwindow, l"
      "$mainMod SHIFT, L, swapwindow, r"
      "$mainMod SHIFT, K, swapwindow, u"
      "$mainMod SHIFT, J, swapwindow, d"
      "$mainMod, s, exec, grimblast copysave active ${screenshotPath}"
      "$mainMod SHIFT, s, exec, grimblast copysave area ${screenshotPath}"
      "alt, PRINT, exec, grimblast copysave active ${screenshotPath}"
      ",PRINT, exec, grimblast copysave active ${screenshotPath}"
      "$mainMod SHIFT, c, exec, notify-send \"Color: $(hyprpicker)\""
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod, GRAVE, togglespecialworkspace, magic"
      "$mainMod SHIFT, GRAVE, movetoworkspace, special:magic"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"
    ];
    # m: Mouse: Will work with mouse buttons
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    # l: locked: Will work when an input inhibitor is active (e.g. lock screen)
    bindl = [
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPrev, exec, playerctl previous"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPause, exec, playerctl play-pause"
    ];
    # e: repeat: Will repeat when the key is held down
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ", XF86KbdBrightnessUp, exec, brightnessctl --device ${kbdBacklightDev} set ${kbdBacklightStep}+"
      ", XF86KbdBrightnessDown, exec, brightnessctl --device ${kbdBacklightDev} set ${kbdBacklightStep}-"
      ", XF86Launch4, exec, powerprofiles-next"
      ", XF86Launch1, exec, ${launcher} -show drun -icon-theme ${iconTheme} -show-icons"
      "$mainMod, equal, resizeactive, ${resizeStep} 0"
      "$mainMod, minus, resizeactive, -${resizeStep} 0"
      "$mainMod SHIFT, equal, resizeactive, 0 ${resizeStep}"
      "$mainMod SHIFT, minus, resizeactive, 0 -${resizeStep}"
    ];
    gesture = [
      "4, horizontal, workspace"
    ];
  };
}
