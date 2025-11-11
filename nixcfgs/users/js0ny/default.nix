# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  config,
  ...
}: let
  username = "js0ny";
in {
  imports = [
    ../../modules/home/options.nix
    ../../modules/home/do-not-track.nix
    ./config.nix
  ];
  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  programs.home-manager.enable = true;

  home.sessionVariables.TERMINAL = config.currentUser.defaultTerminal;
}
