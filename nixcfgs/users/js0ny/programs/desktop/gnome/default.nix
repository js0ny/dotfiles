{
  pkgs,
  config,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    dash-to-dock
    caffeine
    kimpanel
    appindicator
    gsconnect
    advanced-alttab-window-switcher
    resource-monitor
    lunar-calendar
    arcmenu
    run-or-raise
  ];
in {
  imports = [
    ./copyous.nix
  ];
  home.packages = with pkgs;
    [
      gnome-tweaks
      sushi
      nautilus-open-any-terminal
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
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-last = ["<Super>9"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      move-to-workspace-6 = ["<Shift><Super>6"];
      move-to-workspace-7 = ["<Shift><Super>7"];
      move-to-workspace-8 = ["<Shift><Super>8"];
      move-to-workspace-last = ["<Shift><Super>9"];
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
      # www = ["<Super>b"]; # use run-or-raise instead
      help = [""];
      home = ["<Super>e"];
      screenreader = [""];
      screensaver = [""];
    };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0" = {
    #   name = "Open File Explorer";
    #   command = "dolphin";
    #   binding = "<Super>e";
    # };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1" = {
      name = "Open Terminal via Win-CR";
      command = "xdg-terminal";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2" = {
      name = "Open Terminal via Ctrl-Alt-T";
      command = "xdg-terminal";
      binding = "<Ctrl><Alt>t";
    };
    # use arcmenu
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-3" = {
    #   name = "Open Picker";
    #   command = "walker";
    #   binding = "<Alt>space";
    # };
    # "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-4" = {
    #   name = "Open Obsidian";
    #   command = "Obsidian";
    #   binding = "<Super>O";
    # };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-2/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-3/"
        # "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom-4/"
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
        "/home/${config.home.username}/Obsidian"
        "/home/${config.home.username}/Atelier"
        "/home/${config.home.username}/Academia"
      ];
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
      customleftclickstatus = "missioncenter";
    };
    "org/gnome/shell/extensions/arcmenu" = {
      "menu-button-icon" = "nix-snowflake-white";
      "menu-button-icon-size" = 25;
      "runner-hotkey" = ["<Alt>space"];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      # shortcut: Hit to focus the dock
      # disable this behaviour as it conflicts with *QUIT*
      # Default: <Super>Q
      shortcut = [];
      # scroll action: mouse scroll on dock icons
      # Default: 'do-nothing
      # Options: 'do-nothing', 'cycle-windows', 'switch-workspace'
      scroll-action = "cycle-windows";
      dock-position = "BOTTOM";
    };
    "org/gnome/shell/extensions/advanced-alttab-window-switcher" = {
      # Show Hotkeys F1-F12 for Direct Activation
      switcher-popup-hot-keys = true;
      # Tooltip Titles:
      # 1: Disabled
      # 2: Show Above/Below Item (Default)
      # 3: Show Centered
      switcher-popup-tooltip-title = 3;
    };
  };
  xdg.configFile."run-or-raise/shortcuts.conf". text = ''
    <Super>b,firefox,,
    <Super>o,obsidian,,
    <Shift><Super>e,fsearch,,
    <Alt><Super>e,xdg-terminal-exec --app-id=terminal-popup yazi
    <Alt><Super>Return,neovide,,
    <Shift><Super>v,kitty -o close_on_child_death=yes --app-id=terminal-popup -e edit-clipboard --minimal
  '';
}
