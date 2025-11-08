{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi
    rofimoji
    rofi-power-menu
  ];

  # The default desktop entry does not have `categories` field, add it manually.
  xdg.desktopEntries = {
    "rofi" = {
      name = "Rofi";
      genericName = "Launcher";
      comment = "A versatile window switcher, application launcher, and dmenu replacement";
      icon = "rofi";
      type = "Application";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
      exec = "rofi -show";
    };
    "rofi-theme-selector" = {
      name = "Rofi Theme Selector";
      genericName = "Theme Selector";
      comment = "Select a theme for Rofi";
      icon = "rofi";
      type = "Application";
      terminal = false;
      categories = [
        "System"
        "Utility"
      ];
      exec = "rofi-theme-selector";
    };
  };
}
