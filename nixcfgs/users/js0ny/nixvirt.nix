# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  nix-flatpak,
  plasma-manager,
  ...
}:
{
  imports = [
    ./default.nix
    ./programs/gnome.nix
    ./programs/shell.nix
    ./programs/git.nix
    ./programs/firefox.nix
    # ./programs/floorp.nix
    ../../modules/home/gnome-keyrings.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/dev/python.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix
    # ./flatpak.nix
  ];

  home.stateVersion = "25.05";
}
