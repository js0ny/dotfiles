{pkgs, ...}: let
  aliasCfg = import ./aliases.nix {pkgs = pkgs;};
in {
  programs.bash = {
    enable = true;
    shellAliases = aliasCfg.aliases;
    bashrcExtra = ''
      ${aliasCfg.posixFx}
    '';
  };
}
