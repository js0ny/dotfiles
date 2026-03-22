# Run nightly:
# nix run "github:nix-community/flake-firefox-nightly#firefox-nightly-bin"
{...}: {
  imports = [
    ./addons.nix
    ./userjs.nix
    ./keymaps.nix
    ./search.nix
    ./betterfox.nix
  ];
  programs.firefox = {
    enable = true;
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
