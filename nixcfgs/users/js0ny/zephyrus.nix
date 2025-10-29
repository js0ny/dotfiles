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

    # Shell
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix

    # Desktop Linux
    ./programs/plasma.nix

    # General Program config
    ../../modules/home/programs/eza.nix
    ../../modules/home/programs/winboat.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    # Development setup
    ../../modules/home/dev/c.nix
    ../../modules/home/dev/go.nix
    ../../modules/home/dev/java.nix
    ../../modules/home/dev/lua.nix
    ../../modules/home/dev/nix.nix
    ../../modules/home/dev/python.nix
    ../../modules/home/dev/typst.nix
    ../../modules/home/dev/verilog.nix
  ];

  home.stateVersion = "25.05";
}
