{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  cherryStudioConfig = mkMergedJson {
    name = "cherry-studio-config";
    target = ".config/cherry-studio/config.json";
    settings = {
      enableDeveloperMode = true;
      enableDataCollection = false;
      autoUpdate = false;
      language = "zh-CN";
      theme = "system";
      tray = true;
      enableQuickAssistant = true;
      clickTrayToShowQuickAssistant = true;
      launchToTray = false;
    };
  };
in {
  home.packages = [
    pkgs.cherry-studio
  ];
  imports = [
    cherryStudioConfig
  ];
}
