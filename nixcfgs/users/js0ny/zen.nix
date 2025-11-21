{lib, ...}: {
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
    ./programs/nvim.nix
    ./programs/pdf2zh/uv.nix
    ./programs/yazi.nix
    ./programs/edit-clipboard.nix
    ./programs/neovide.nix
    ./programs/ghostty.nix

    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    ../../modules/home/dev/nix.nix
  ];

  home.sessionPath = ["/opt/homebrew/bin"];

  programs.nh = {
    enable = true;
    flake = "/Users/js0ny/.dotfiles/nixcfgs";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  xdg.desktopEntries = lib.mkForce {};

  home.stateVersion = "25.05";
}
