{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
    sushi
    dconf-editor
    gnomeExtensions.dash-to-dock
    gnomeExtensions.caffeine
    gnomeExtensions.logo-menu
    gnomeExtensions.kimpanel
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.advanced-alttab-window-switcher
    gnomeExtensions.paperwm
    gnomeExtensions.blur-my-shell
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
  ];
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = [
    {package = pkgs.gnomeExtensions.dash-to-dock;}
    {package = pkgs.gnomeExtensions.caffeine;}
    {package = pkgs.gnomeExtensions.logo-menu;}
    {package = pkgs.gnomeExtensions.kimpanel;}
    {package = pkgs.gnomeExtensions.appindicator;}
    {package = pkgs.gnomeExtensions.gsconnect;}
    {package = pkgs.gnomeExtensions.clipboard-indicator;}
    {package = pkgs.gnomeExtensions.advanced-alttab-window-switcher;}
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      icon-theme = "Papirus";
      accent-color = "pink";
      show-battery-percentage = true;
      cursor-theme = "Adwaita";
    };
    "org/gnome/epiphany" = {
      ask-for-default = false;
    };
    "org/gnome/epiphany/web" = {
      remember-passwords = false;
      enable-mouse-gestures = true;
    };
    "org/gnome/shell/extensions/Logo-menu" = {
      menu-button-icon-image = 23;
      symbolic-icon = true;
      use-custom-icon = false;
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "firefox.desktop"
        "code.desktop"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0" = {
      name = "Open File Explorer";
      command = "dolphin";
      binding = "<Super>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1" = {
      name = "Open Terminal via Win-R";
      command = "ghostty";
      binding = "<Super>r";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2" = {
      name = "Open Terminal via Ctrl-Alt-T";
      command = "ghostty";
      binding = "<Ctrl><Alt>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2/"
      ];
    };
  };

  # qt.style.name = "adwaita";
}
