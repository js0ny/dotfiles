{...}: {
  imports = [
    ./default.nix
    ./programs/shell.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/fzf.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/nvim.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix
  ];

  home.stateVersion = "25.05";
}
