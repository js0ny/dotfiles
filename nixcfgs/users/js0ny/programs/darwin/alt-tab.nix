# brew install alt-tab
{...}: let
  hideList = [
    "com.apple.finder"
    "com.apple.Preview"
  ];
  ignoreList = [
    "com.microsoft.rdc.macos"
    "com.teamviewer.TeamViewer"
    "org.virtualbox.app.VirtualBoxVM"
    "com.parallels."
    "com.citrix.XenAppViewer"
    "com.citrix.receiver.icaviewer.mac"
    "com.nicesoftware.dcvviewer"
    "com.apple.ScreenSharing"
  ];
  mkHideApps = identifier: {
    "hide" = "2";
    "bundleIdentifier" = identifier;
    "ignore" = "0";
  };
  mkIgnoreApps = identifier: {
    "bundleIdentifier" = identifier;
    "hide" = "0";
    "ignore" = "2";
  };
  blocklist = builtins.toJSON (map mkHideApps hideList ++ map mkIgnoreApps ignoreList);
in {
  targets.darwin.defaults = {
    "com.lwouis.alt-tab-macos" = {
      # 0: Small
      # 1: Medium
      # 2: Large
      appearanceSize = 1;
      # 0: Thumbnails (Recording permission required)
      # 1: App Icons
      # 2: Titles
      appearanceStyle = 0;
      # 0: Normal
      # 1: High
      # 2: Highest
      appearanceVisibility = 2;
      # 0: Light
      # 1: Dark
      # 2: System
      appearanceTheme = 2;

      # Shortcut 1: Cmd-Tab - Mimic Alt-Tab in Windows
      # U+2318
      holdShortcut = "⌘";
      # U+21e5
      nextWindowShortcut = "⇥";
      # TODO: Shortcut 2:
      holdShortcut2 = "⌘";

      previewFocusedWindow = true;
      showTabsAsWindows = false;
      hideAppBadges = false;
      # 0: Leading
      # 1: Center
      alignThumbnails = 1;
      menubarIcon = 0;
      menubarIconShown = false;
      # 0: Don't check for update
      # 1: Check for update
      # 2: Auto Update
      updatePolicy = 0;
      # 0: Never send crash report
      # 1: Ask
      # 2: Always send
      crashPolicy = 0;
      vimKeysEnabled = true;
      blacklist = toString blocklist;
    };
  };
}
