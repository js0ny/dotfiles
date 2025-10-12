{
  pkgs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;

    languagePacks = ["zh-CN"];

    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
      "screenshots.browser.component.enabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.contentblocking.category" = "strict";
      "browser.formfill.enable" = false;
      "extensions.formautofill.creditCards.enabled" = false;
      "dom.forms.autocomplete.formautofill" = false;
      "browser.urlbar.update2.engineAliasRefresh" = true;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    };

    policies = {
      DisableTelemetry = true;
      BlockAboutConfig = false;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;

      ExtensionSettings = with builtins; let
        extension = short: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "multi-account-containers" "@testpilot-containers")
          (extension "side-view" "@webcompat@mozilla.org")
          (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
        ];

      SearchEngines = {
        Default = "DuckDuckGo";
        Add = [
          {
            Alias = "@np";
            Description = "Search in NixOS Packages";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@no";
            Description = "Search in NixOS Options";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?from=0&size=200&sort=relevance&type=packages&query={searchTerms}";
          }
          {
            Alias = "@hm";
            Description = "Search in Home Manager Options";
            IconURL = "https://nixos.org/favicon.ico";
            Method = "GET";
            Name = "Home Manager options";
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
          }
        ];
      };
    };
  };
}
