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
    ./programs/browsers/firefox
    ./programs/editors/emacs.nix
    ./programs/editors/zed-editor.nix
    ./programs/rime
    ./programs/productivity/sdcv.nix
    ./programs/fzf.nix
    ./programs/sops.nix
    ./programs/editors/nvim.nix
    ./programs/pdf2zh/uv.nix
    ./programs/yazi.nix
    ./programs/edit-clipboard.nix
    ./programs/editors/neovide.nix
    ./programs/terminals/ghostty.nix
    ./programs/terminals/tmux.nix
    ./programs/terminals/kitty.nix
    ./programs/productivity/anki.nix
    ./programs/productivity/sioyek
    ./programs/social/telegram.nix
    # ./programs/retroarch.nix # Package broken on macOS
    ./programs/darwin/duti.nix
    ./programs/darwin/alt-tab.nix
    ./programs/darwin/iina.nix

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
