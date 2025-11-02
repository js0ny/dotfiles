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
    ./config.nix
  ];
  home.username = username;
  home.homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}"
    else "/home/${username}";

  home.packages = with pkgs; [
    home-manager
  ];

  home.sessionVariables.TERMINAL = config.currentUser.defaultTerminal;

  home.stateVersion = "25.05";
}
