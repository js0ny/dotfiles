{pkgs, ...}: let
  aliases = import ./aliases.nix {pkgs = pkgs;};
in {
  programs.nushell = {
    enable = true;
    shellAliases = aliases;
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };
}
