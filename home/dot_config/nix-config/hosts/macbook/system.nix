{ config, pkgs, ... }:

{
  time.timeZone = "Asia/Shanghai";
  system.defaults = {
    dock = {
      appswitcher-all-displays = true;
      autohide = true;
      # Launch Animation
      launchanim = false;
      # Minimize Animation
      mineffect = "suck";
      minimize-to-application = true;
      persistent-apps = [
        { app = "/Applications/Vivaldi.app"; }
        { app = "/Applications/kitty.app"; }
        { app = "/Applications/Obsidian.app"; }
        { app = "Applications/Visual Studio Code.app"; }
        { app = "/Applications/LibreWolf.app"; }
        # { spacer = { small = false; }; }
        # { spacer = { small = true; }; }
        # { folder = "/System/Applications/Utilities"; }
        # { folder = "/Users/js0ny/Downloads/"; }
      ];
      persistent-others = [
        "/Users/js0ny/Downloads"
        "/Users/js0ny/Source"
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
    finder = {
      AppleShowAllFiles = true;
      ShowStatusBar = true;
      ShowPathbar = true;
      FXRemoveOldTrashItems = true;
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      ShowExternalHardDrivesOnDesktop = false;
      ShowRemovableMediaOnDesktop = false;
      # This will look show full path in title bar
      # For example: /Users/username/Downloads
      # instead of just Downloads
      _FXShowPosixPathInTitle = false;
      _FXSortFoldersFirst = true;
      FXEnableExtensionChangeWarning = false;
      # Use `Home` instead of `PfHm`
      # nix-darwin won't parse `PfHm`
      NewWindowTarget = "Home";
    };
    trackpad = {
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
      include-date = true;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    ".GlobalPreferences" = {
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = true;
      AppleShowAllExtensions = true;
      # Use Fn key as standard function keys instead of media keys
      "com.apple.keyboard.fnState" = true;
      AppleMeasurementUnits = "Centimeters";
      AppleICUForce24HourTime = true;
    };
    controlcenter.BatteryShowPercentage = true;
    # Fn usage:
    # 0: Show Emoji & Symbols
    # 1: Change Input Source
    # 2: Show Emoji & Symbols
    # 3: Start Dictation
    hitoolbox.AppleFnUsageType = "Change Input Source";
    WindowManager = {
      EnableTilingByEdgeDrag = true;
      EnableTopTilingByEdgeDrag = true;
      EnableTilingOptionAccelerator = true;
      EnableTiledWindowMargins = true;
    };
    # universalaccess = {
    #   mouseDriverCursorSize = 1.5;
    #   reduceMotion = true;
    #   reduceTransparency = false;
    # };
    menuExtraClock = {
      ShowSeconds = true;
    };
  };
}