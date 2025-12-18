{
  pkgs,
  config,
  lib,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergeIni = mergetools.mkMergedIni;
  elisarc = mkMergeIni {
    name = "elisarc";
    target = ".config/elisarc";
    settings = {
      ElisaFileIndexer = {
        "RootPath[$e]" = "$HOME/Music";
      };
    };
  };
in {
  imports = [elisarc];
  home.packages = with pkgs.kdePackages; [
    elisa
  ];
}
