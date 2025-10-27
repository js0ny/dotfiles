{pkgs, ...}: let
  aliases = import ./aliases.nix {pkgs = pkgs;};
in {
  programs.bash = {
    enable = true;
    shellAliases = aliases;
  };
}
