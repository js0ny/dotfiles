# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  nix-flatpak,
  plasma-manager,
  ...
}:
{
  imports = [
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/zoxide.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "js0ny";
  home.homeDirectory = "/home/js0ny";

  home.packages = with pkgs; [
    home-manager
  ];

  home.stateVersion = "25.05";
}
