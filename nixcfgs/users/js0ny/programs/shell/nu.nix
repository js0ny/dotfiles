{pkgs, ...}: let
  aliases = import ./aliases.nix {pkgs = pkgs;};
in {
  programs.nushell = {
    enable = true;
    shellAliases = {
      "la" = "ls -a";
      "lt" = "lsd --tree";
    };
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };
}
