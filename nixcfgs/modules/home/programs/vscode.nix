{pkgs, ...}: let
  alias = {"c" = "codium";};
in {
  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
  };
  programs.fish.shellAbbrs = alias;
  programs.bash.shellAliases = alias;
  programs.zsh.shellAliases = alias;
}
