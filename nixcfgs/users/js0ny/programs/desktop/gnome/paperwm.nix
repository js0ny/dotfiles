{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    paperwm
  ];
  programs.gnome-shell.extensions = [
    {package = pkgs.gnomeExtensions.paperwm;}
  ];
  dconf.settings = {
    # Inspect window class with <Alt>F2 -> `lg`
    # scratch_layer: true makes the window float above others
    "org/gnome/shell/extensions/paperwm" = {
      winprops = [
        ''{"wm_class":"dev.benz.walker","scratch_layer":true}''
        ''{"wm_class":"org.pulseaudio.pavucontrol","scratch_layer":true}''
        ''{"wm_class":"mpv","scratch_layer":true}''
        ''{"wm_class":"org.gnome.NautilusPreviewer","scratch_layer":true}''
        ''{"wm_class":"terminal-popup","scratch_layer":true}''
        ''{"wm_class":"fsearch","scratch_layer":true}''
        ''{"wm_class":"QQ","title":"资料卡","scratch_layer":true}''
        ''{"wm_class":"","title":"Floating Window - Show Me The Key","scratch_layer":true}''
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Alt><Super>i"];
    };
    "org/gnome/shell/extensions/paperwm/keybindings" = {
      close-window = ["<Super>q"];
      new-window = [];
      switch-next = [];
      switch-previous = [];
      switch-left = [
        "<Super>Left"
        "<Super>h"
      ];
      switch-right = [
        "<Super>Right"
        "<Super>l"
      ];
      switch-down = [
        "<Super>Down"
        "<Super>j"
      ];
      switch-up = [
        "<Super>Up"
        "<Super>k"
      ];
      move-left = ["<Shift><Super>h"];
      move-right = ["<Shift><Super>l"];
      move-up = [""];
      move-down = [""];
      switch-down-or-else-workspace = ["<Super><Shift>j"];
      switch-up-or-else-workspace = ["<Super><Shift>k"];
      center-vertically = [""];
      drift-left = [""];
      drift-right = [""];
      move-up-workspace = ["<Control><Super>k"];
      move-down-workspace = ["<Control><Super>j"];
      slurp-in = ["<Super>bracketleft"];
      barf-out = ["<Super>bracketright"];
      barf-out-active = [];
      # Use AATWS
      live-alt-tab = [];
      live-alt-tab-backward = [];
    };
  };
}
