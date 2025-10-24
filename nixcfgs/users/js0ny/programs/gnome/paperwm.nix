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
      move-left = [
        "<Control><Super>comma"
        "<Shift><Super>comma"
        "<Control><Super>Left"
        "<Shift><Super>h"
      ];
      move-right = [
        "<Control><Super>comma"
        "<Shift><Super>comma"
        "<Control><Super>Left"
        "<Shift><Super>l"
      ];
      move-up = [
        "<Control><Super>comma"
        "<Shift><Super>comma"
        "<Control><Super>Left"
        "<Shift><Super>k"
      ];
      move-down = [
        "<Control><Super>comma"
        "<Shift><Super>comma"
        "<Control><Super>Left"
        "<Shift><Super>j"
      ];
      center-vertically = [""];
      drift-left = [""];
      drift-right = [""];
      move-up-workspace = ["<Control><Super>k"];
      move-down-workspace = ["<Control><Super>j"];
    };
  };
}
