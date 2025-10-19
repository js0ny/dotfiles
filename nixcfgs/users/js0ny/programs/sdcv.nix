{ pkgs }:
{
  home.packages = with pkgs; [
    sdcv
  ];
  home.sessionVariables = {
    STARDICT_DATA_DIR = "$HOME/.local/share/stardict/dic";
  };
}
