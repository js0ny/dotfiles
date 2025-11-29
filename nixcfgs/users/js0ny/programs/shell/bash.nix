{
  pkgs,
  config,
  lib,
  ...
}: let
  aliasCfg = import ./aliases.nix {inherit pkgs config lib;};
in {
  programs.bash = {
    enable = true;
    shellAliases = aliasCfg.aliases;
    bashrcExtra = ''
      ${aliasCfg.posixFx}
    '';
  };
}
