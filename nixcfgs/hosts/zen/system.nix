{ config, pkgs, ... }:
  {
  system.defaults = {
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
