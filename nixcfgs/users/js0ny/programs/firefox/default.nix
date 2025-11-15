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
        "extensions.update.enabled" = true;
        "sidebar.expandOnHover" = true;
        "sidebar.visibility" = "expand-on-hover";
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
}
