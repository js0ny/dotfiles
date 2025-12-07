{
  pkgs,
  config,
  lib,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    # dash-to-dock
    caffeine
    logo-menu
    kimpanel
    appindicator
    gsconnect
    clipboard-indicator
    advanced-alttab-window-switcher
    resource-monitor
    lunar-calendar
  ];
in {
  imports = [
    ../../walker.nix
  ];
  home.packages = with pkgs;
    [
      gnome-tweaks
      sushi
      dconf-editor
      gnome-menus
      showtime
      gobject-introspection
    ]
    ++ extensions;
  programs.gnome-shell.enable = true;
  programs.gnome-shell.extensions = let
    extensionHelper = p: {
      package = p;
    };
  in
    map extensionHelper extensions;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      clock-show-seconds = true;
      clock-show-weekday = true;
      accent-color = "pink";
      show-battery-percentage = true;
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
        "kitty.desktop"
        "firefox.desktop"
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
    "org/gnome/desktop/wm/preferences" = {
      # Win + Right Mouse Button to Resize Window
      resize-with-right-button = true;
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
      home = ["<Super>e"];
      screenreader = [""];
      screensaver = [""];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0" = {
      name = "Open File Explorer";
      command = "dolphin";
      binding = "<Super>e";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1" = {
      name = "Open Terminal via Win-CR";
      command = "${lib.getExe config.my.desktop.preferredApps.terminal.package}";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2" = {
      name = "Open Terminal via Ctrl-Alt-T";
      command = "${lib.getExe config.my.desktop.preferredApps.terminal.package}";
      binding = "<Ctrl><Alt>t";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-3" = {
      name = "Open Picker";
      command = "walker";
      binding = "<Alt>space";
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-3/"
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
}
