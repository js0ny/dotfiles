# ~/.config/nixcfgs/users/js0ny/default.nix
{ pkgs, ... }:
let
  username = "js0ny";
in
{
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

  home.packages = with pkgs; [
    home-manager
  ];

  home.stateVersion = "25.05";
}
