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
        ### Disable Menu when pressing <Alt>
        "ui.key.menuAccessKey" = -1;
        "ui.key.menuAccessKeyFocuses" = false;
        ### Disable Translations
        "browser.translations.enable" = false;
        "browser.translations.automaticallyPopup" = false;
        ### CJK IME Optimisation
        "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
        "browser.tabs.closeTabByDblclick" = true;
        ### Session
        # * 0: Blank Page
        # * 1: Home Page
        # * 2: Last Visited Pages
        # * 3: Restore Previous Session
        "browser.startup.page" = 3;
        "browser.sessionstore.resume_from_crash" = true;
        ### Sync
        "services.sync.declinedEngines" = "creditcards,passwords,addresses,prefs,addons";
        "services.sync.engine.addons" = false;
        "services.sync.engine.addresses" = false;
        "services.sync.engine.bookmarks" = true;
        "services.sync.engine.creditcards" = false;
        "services.sync.engine.history" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.prefs.modified" = false;
        "services.sync.engine.tabs" = true;
        "services.sync.engins.tabs.filteredSchemes" = "about|resource|chrome|file|blob|moz-extension|data";
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
