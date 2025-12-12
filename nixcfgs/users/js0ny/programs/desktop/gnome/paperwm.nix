{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    paperwm
  ];
  programs.gnome-shell.extensions = [
    {package = pkgs.gnomeExtensions.paperwm;}
  ];
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [""];
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
    };
    "org/gnome/shell/extensions/paperwm" = {
      winprops = [''{"wm_class":"dev.benz.walker","scratch_layer":true}''];
    };
  };
}
