{pkgs, ...}: {
  imports = [
    ./shell.nix
    ./vscodium.nix
    ../../../modules/home/dev/java.nix
    ../../../modules/home/dev/python.nix
    ../../../modules/home/programs/eza.nix
    ../../../modules/home/programs/fzf.nix
    ../../../modules/home/programs/lsd.nix
    ../../../modules/home/programs/nvim.nix
    ../../../modules/home/programs/rime.nix
    ../../../modules/home/programs/starship.nix
    ../../../modules/home/programs/zed-editor.nix
    ../../../modules/home/programs/zoxide.nix
  ];
}
