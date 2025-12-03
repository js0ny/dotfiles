# Run nightly:
# nix run "github:nix-community/flake-firefox-nightly#firefox-nightly-bin"
{...}: {
  imports = [
    ./addons.nix
    ./search.nix
    ./betterfox.nix
  ];
  programs.firefox = {
    enable = true;
    profiles.default = {
      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";
        "extensions.update.enabled" = true;
        "sidebar.expandOnHover" = true;
        "sidebar.visibility" = "expand-on-hover";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.tabbox.switchByScrolling" = true;
        "browser.uidensity" = 1;
        # Disable Menu when pressing <Alt>
        "ui.key.menuAccessKey" = -1;
        "ui.key.menuAccessKeyFocuses" = false;
        # Disable Translations
        "browser.translations.enable" = false;
        "browser.translations.automaticallyPopup" = false;
        # CJK IME Optimisation
        "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
        "browser.tabs.closeTabByDblclick" = true;
      };
    };
  };

  xdg.desktopEntries."firefox-private" = {
    name = "Firefox Private Window";
    genericName = "Web Browser";
    icon = "firefox-nightly";
    type = "Application";
    terminal = false;
    categories = [
      "Network"
      "WebBrowser"
    ];
    exec = "firefox --private-window %U";
  };
}
