{config, pkgs, ...}: let
  aliases = import ./aliases.nix { pkgs = pkgs; };
in {
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = aliases;
  };
}