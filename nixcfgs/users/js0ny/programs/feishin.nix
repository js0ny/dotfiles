{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  feishinConfig = mkMergedJson {
    name = "feishin-config";
    target = ".config/feishin/config.json";
    settings = {
      theme = "system";
      window_has_frame = false;
      release_channel = "latest";
      global_media_hotkeys = true;
      window_window_bar_style = "windows";
      disable_auto_updates = true;
    };
  };
in {
  home.packages = [
    pkgs.feishin
  ];
  imports = [
    feishinConfig
  ];
}
