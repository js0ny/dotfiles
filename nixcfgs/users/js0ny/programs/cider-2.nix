{
  pkgs,
  lib,
  config,
  ...
}: let
  catppuccinCider = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "cider";
    rev = "d336144a63f7dc1510b072cfb94eda1730db45cb";
    sha256 = "sha256-wzlRiGDDmVAqAazhhXAl4LepNY/UyyWdLLQVvkHTTSE=";
  };

  ctp-mocha = pkgs.runCommand "cider-theme-ctp-mocha" {} ''
    cp -r ${catppuccinCider}/themes/ctp-mocha $out
    chmod -R u+w $out
    echo "marketplaceID: 12" >> "$out/theme.yml"
    echo 'version: "25.02"' >> "$out/theme.yml"
  '';
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedYaml = mergetools.mkMergedYaml;
  ciderSpaConfig = mkMergedYaml {
    name = "cider-spa-config";
    target = ".config/sh.cider.genten/spa-config.yml";
    settings = {
      general = {
        language = "zh-CN";
        keybindings = {
          commandCenter = ["ctrlKey" "KeyO"];
        };
        closeToTray = true;
        checkForUpdates = false;
      };
      updates = {
        # Managed by Nix, disable built-in update checks
        checkForUpdates = false;
      };
    };
  };
in {
  imports = [
    ../../../modules/home/programs/cider-2.nix
    ciderSpaConfig
  ];

  programs.cider-2 = {
    enable = true;

    # --- Themes ---
    themes = {
      # This maps to ~/.config/sh.cider.genten/themes/12
      "12" = {
        src = ctp-mocha;
      };
    };

    # --- Plugins ---
    plugins = {
      # This maps to ~/.config/sh.cider.genten/plugins/ch.kaifa.listenbrainz
      "ch.kaifa.listenbrainz" = {
        marketplace = {
          id = 10;
          version = "1.1.0";
          sha256 = "sha256-YelqonGEQVZk4+IQ8YwgfqP93a+enN6XxVktlyBCEZI=";
        };
      };
    };
  };
}
