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
    };

    policies = {
      DisableTelemetry = true;
      BlockAboutConfig = false;
      DontCheckDefaultBrowser = true;

      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = moz "ublock-origin";
          installation_mode = "force_installed";
          updates_disabled = true;
        };
      };
    };
  };
}
