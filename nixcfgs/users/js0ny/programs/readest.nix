{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  readestSettings = mkMergedJson {
    name = "readest-settings";
    target = ".config/com.bilingify.readest/settings.json";
    settings = {
      globalViewSettings = {
        serifFont = "LXGW WenKai GB Screen";
        defaultCJKFont = "LXGW WenKai GB Screen";
        sansSerifFont = config.stylix.fonts.sansSerif.name;
        monospaceFont = config.stylix.fonts.monospace.name ++ " Regular";
        uiLanguage = "zh-CN";
      };
      telemetryEnabled = false;
    };
  };
in {
  home.packages = [
    pkgs.readest
  ];
  imports = [
    readestSettings
  ];
}
