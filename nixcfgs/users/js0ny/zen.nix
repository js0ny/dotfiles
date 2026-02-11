{...}: {
  imports = [
    ./default.nix

    # Packages
    ./packages/cli.nix
    ./packages/stylix.nix

    # Shell
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/shell/carapace.nix
    ./programs/shell/direnv.nix

    # Programs
    ./programs/aichat.nix
    ./programs/firefox
    ./programs/emacs.nix
    ./programs/zed-editor.nix
    ./programs/rime
    ./programs/sdcv.nix
    ./programs/fzf.nix
    ./programs/sops.nix
    ./programs/nvim.nix
    ./programs/pdf2zh/uv.nix
    ./programs/yazi.nix
    ./programs/edit-clipboard.nix
    ./programs/neovide.nix
    ./programs/ghostty.nix
    ./programs/tmux.nix
    ./programs/kitty.nix
    ./programs/anki.nix
    ./programs/sioyek
    ./programs/telegram.nix
    # ./programs/retroarch.nix # Package broken on macOS
    ./programs/darwin/duti.nix
    ./programs/darwin/alt-tab.nix
    ./programs/darwin/iina.nix

    ../../modules/home/do-not-track.nix
    ../../modules/home/darwin.nix

    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    ../../modules/home/dev/nix.nix
  ];

  targets.darwin.defaults = {
    ".GlobalPreferences" = {
      # Accent Colour: Pink
      "AppleAccentColor" = 6;
      # Folder Colour
      "AppleIconAppearanceTintColor" = "Yellow";
      # Icon & Widget Style
      "AppleInterfaceStyle" = "Dark";
    };
  };

  home.stateVersion = "25.05";
}
