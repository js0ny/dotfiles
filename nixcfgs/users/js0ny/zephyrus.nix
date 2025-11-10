# ~/.config/nixcfgs/users/js0ny/default.nix
{...}: {
  imports = [
    # General config
    ./default.nix

    # Use Gnome-keyring for GUI setup
    ../../modules/home/gnome-keyrings.nix

    # Packages
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/flatpak.nix
    ./packages/fonts.nix
    ./packages/catppuccin.nix

    # Shell
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/shell/direnv.nix

    # Personal Program
    ./programs/chromium.nix
    ./programs/firefox.nix
    ./programs/emacs.nix
    ./programs/vscode.nix
    ./programs/xilinx.nix
    ./programs/mime.nix
    ./programs/zed-editor.nix
    ./programs/rime.nix
    ./programs/sdcv.nix
    ./programs/fzf.nix
    ./programs/libreoffice.nix
    ./programs/nvim.nix
    ./programs/ollama.nix
    ./programs/sops.nix
    ./programs/pdf2zh.nix

    # Desktop Linux
    ./programs/desktop/plasma.nix
    ./programs/desktop/wayland-wm/niri.nix

    # General Program config
    ../../modules/home/programs/eza.nix
    # ../../modules/home/programs/winboat.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    # Development setup
    ../../modules/home/dev/nix.nix
  ];

  home.stateVersion = "25.05";
}
