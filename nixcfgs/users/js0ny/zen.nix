{...}: {
  imports = [
    ./default.nix

    # Packages
    ./packages/cli.nix
    ./packages/catppuccin.nix

    # Shell
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/shell/direnv.nix

    # Programs
    ./programs/firefox
    ./programs/zed-editor.nix
    ./programs/rime.nix
    ./programs/sdcv.nix
    ./programs/fzf.nix
    ./programs/sops.nix
    ./programs/nvim.nix
    ./programs/pdf2zh/uv.nix
    ./programs/yazi.nix
    ./programs/edit-clipboard.nix
    ./programs/neovide.nix
    ./programs/ghostty.nix

    ../../modules/home/do-not-track.nix
    ../../modules/home/darwin.nix

    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    ../../modules/home/dev/nix.nix
  ];

  home.stateVersion = "25.05";
}
