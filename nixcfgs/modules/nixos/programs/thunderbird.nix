{...}: {
  programs.thunderbird = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      ExtensionSettings = with builtins; let
        extension = short: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.thunderbird.net/downloads/latest/addon-${short}-latest.xpi";
            installation_mode = "normal_installed";
          };
        };
      in
        listToAttrs [
          (extension "988699" "thunderai@micz.it") # ThunderAI
          (extension "988018" "addon@darkreader.org") # Dark Reader
          (extension "987885" "tbkeys-lite@addons.thunderbird.net") # TBKeys Lite
          (extension "988342" "external-editor-revived@tsundere.moe") # External Editor Revived
        ];
    };
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
    };
  };
}
