{pkgs, ...}: {
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita";
  };
  home.packages = with pkgs; [
    gnome-tweaks
    sushi
    dconf-editor
    gnome-menus
    adwaita-qt
    adwaita-qt6
    gobject-introspection
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
    gnomeExtensions.resource-monitor
    gnomeExtensions.lunar-calendar
  ];
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = [
    # { package = pkgs.gnomeExtensions.dash-to-dock; }
    {package = pkgs.gnomeExtensions.caffeine;}
    {package = pkgs.gnomeExtensions.logo-menu;}
    {package = pkgs.gnomeExtensions.kimpanel;}
    {package = pkgs.gnomeExtensions.appindicator;}
    {package = pkgs.gnomeExtensions.gsconnect;}
    {package = pkgs.gnomeExtensions.clipboard-indicator;}
    {package = pkgs.gnomeExtensions.advanced-alttab-window-switcher;}
    {package = pkgs.gnomeExtensions.resource-monitor;}
    {package = pkgs.gnomeExtensions.lunar-calendar;}
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
    "org/gnome/shell" = {
      favorite-apps = [
        "com.mitchellh.ghostty.desktop"
        "firefox.desktop"
        "code.desktop"
      ];
    };
    "org/gnome/shell/keybindings" = {
      toggle-overview = ["<Super>w"];
      toggle-message-tray = ["<Super>n"];
      # G14 Compatibility
      show-screenshot-ui = [
        "<Shift><Super>s"
        "Print"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = ["<Alt>F3"];
      show-desktop = ["<Super>d"];
      close = [
        "<Super>q"
        "<Alt>F4"
      ];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
      switch-applications = ["<Super>Tab"];
      switch-applications-backward = ["<Shift><Super>Tab"];
      minimize = ["<Super>m"];
      maximize = [
        "<Shift><Super>m"
        "<Super>Up"
      ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [
        "<Super>Left"
        "<Shift><Super>H"
      ];
      toggle-tiled-right = [
        "<Super>Right"
        "<Shift><Super>L"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      www = ["<Super>b"];
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
    # Scanned directory in GNOME Search
    "org/freedesktop/tracker/miner/files" = {
      "index-recursive-directories" = [
        "&DESKTOP"
        "&DOCUMENTS"
        "&MUSIC"
        "&PICTURES"
        "&VIDEOS"
        "/home/js0ny/Obsidian"
      ];
    };
    "ca/desrt/dconf-editor" = {
      show-warning = false;
    };
    # Extension settings
    "org/gnome/shell/extensions/Logo-menu" = {
      menu-button-icon-image = 23;
      symbolic-icon = true;
      use-custom-icon = false;
    };
    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = ["<Super>v"];
    };
    "org/gnome/shell/extensions/lunar-calendar" = {
      yuyan = 0;
      gen-zhi = false;
      jrrilinei = false;
      show-date = false;
      show-time = false;
    };
    "com/github/Ory0n/Resource_Monitor" = {
      extensionposition = "left";
      iconsposition = "left";
      cpustatus = true;
      netethstatus = false;
      netwlanstatus = false;
      ramalert = true;
      ramunit = "perc";
    };
  };

  # qt.style.name = "adwaita";
}
