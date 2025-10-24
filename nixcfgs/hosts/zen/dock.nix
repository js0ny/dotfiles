{...}: {
  system.defaults.dock = {
    appswitcher-all-displays = true;
    autohide = true;
    # Launch Animation
    launchanim = false;
    # Minimize Animation
    mineffect = "suck";
    minimize-to-application = true;
    persistent-apps = [
      {app = "/Applications/Vivaldi.app";}
      {app = "/Applications/kitty.app";}
      {app = "/Applications/Obsidian.app";}
      {app = "Applications/Visual Studio Code.app";}
      # { app = "/Applications/LibreWolf.app"; }
      # { spacer = { small = false; }; }
      # { spacer = { small = true; }; }
      # { folder = "/System/Applications/Utilities"; }
      # { folder = "/Users/js0ny/Downloads/"; }
    ];
    persistent-others = [
      "/Users/js0ny/Downloads"
      # "/Users/js0ny/Source"
    ];
    show-recents = false;
    orientation = "bottom";
    # tr - Top Right
    # tl - Top Left (disable this)
    # br - Bottom Right
    # bl - Bottom Left
    # `1`: Disabled
    # `2`: Mission Control
    # `3`: Application Windows
    # `4`: Desktop
    # `5`: Start Screen Saver
    # `6`: Disable Screen Saver
    # `7`: Dashboard
    # `10`: Put Display to Sleep
    # `11`: Launchpad
    # `12`: Notification Center
    # `13`: Lock Screen
    # `14`: Quick Note
    wvous-tr-corner = 2;
    wvous-bl-corner = 11; # Simulate Windows button on Windows
    wvous-br-corner = 4;
  };
}
