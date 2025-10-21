# ~/.config/nixcfgs/users/js0ny/polder.nix
{...}: {
  imports = [
    ./default.nix
    ./programs/shell.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
  ];

  home.stateVersion = "25.05";
}
