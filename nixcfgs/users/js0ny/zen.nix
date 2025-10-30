{...}: {
  imports = [
    ./default.nix
    # Shell
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix

    # IME
    ./programs/rime.nix
    ./programs/nvim.nix
    ./programs/fzf.nix
    ./programs/sdcv.nix

    ../../modules/home/dev/nix.nix
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix
  ];

  home.stateVersion = "25.05";
}
