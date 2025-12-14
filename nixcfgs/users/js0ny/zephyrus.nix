# ~/.config/nixcfgs/users/js0ny/default.nix
{
  pkgs,
  config,
  ...
}: let
  username = config.home.username;
in {
  imports = [
    # General config
    ./default.nix

    # Use Gnome-keyring for GUI setup
    ../../modules/home/gnome-keyrings.nix

    # Packages
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/devtools.nix
    ./packages/flatpak.nix
    ./packages/fonts.nix
    ./packages/stylix.nix
    ./packages/media-tools.nix
    ./packages/gaming.nix

    ./programs/antidots.nix

    # Shell
    ./programs/shell/bash.nix
    ./programs/shell/zsh.nix
    ./programs/shell/fish.nix
    ./programs/shell/nu.nix
    ./programs/shell/carapace.nix
    ./programs/shell/direnv.nix

    # Personal Program
    ./programs/chromium.nix
    ./programs/firefox
    ./programs/emacs.nix
    ./programs/vscode.nix
    # ./programs/xilinx.nix
    ./programs/mime.nix
    ./programs/zed-editor.nix
    ./programs/rime.nix
    ./programs/sdcv.nix
    ./programs/fzf.nix
    ./programs/libreoffice.nix
    ./programs/nvim.nix
    ./programs/ollama.nix
    ./programs/sops.nix
    ./programs/pdf2zh/container.nix
    ./programs/gwenview.nix
    ./programs/yazi.nix
    ./programs/dolphin.nix
    ./programs/magick.nix
    ./programs/miniserve.nix
    ./programs/retroarch.nix
    ./programs/neovide.nix
    ./programs/edit-clipboard.nix
    ./programs/discord.nix
    ./programs/mpv.nix
    ./programs/thunderbird.nix
    ./programs/obs-studio.nix
    ./programs/ghostty.nix
    ./programs/obsidian
    ./programs/aichat.nix
    ./programs/tmux.nix
    ./programs/kitty.nix
    ./programs/wine.nix
    ./programs/anki.nix
    ./programs/libvirt.nix
    ./programs/block-desktop-entries.nix
    ./programs/pwa.nix
    ./programs/walker.nix
    ./programs/sioyek.nix
    ./programs/celluloid.nix
    ./programs/picard.nix
    ./programs/cider2.nix

    # Desktop Linux
    ./programs/desktop/gnome
    ./programs/desktop/gnome/paperwm.nix
    ./programs/desktop/gnome/copyous.nix
    ./programs/desktop/wayland-wm/niri

    ../../modules/home/do-not-track.nix

    # General Program config
    ../../modules/home/programs/eza.nix
    # ../../modules/home/programs/winboat.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    # Development setup
    ../../modules/home/dev/nix.nix
  ];

  nixpkgs.config.allowUnfree = true;

  my = {
    desktop = {
      preferredApps = {
        shell = pkgs.zsh;
        interactiveShell = pkgs.fish;
        terminal = {
          package = pkgs.kitty;
          execArg = "-e";
        };
        fileManager = {
          gui = pkgs.kdePackages.dolphin;
          tui = pkgs.yazi;
        };
      };
    };
    hardware = {
      keyboardBacklight = {
        device = "asus::kbd_backlight";
        step = "1";
      };
      isHeadless = false;
    };
  };

  home.sessionVariables = {
    TERMINAL = "xdg-terminal-exec";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # File manager(nautilus) / file chooser bookmarks under GTK file dialogs
  gtk.gtk3.bookmarks = [
    "file:///home/${username}/Academia Academia"
    "file:///home/${username}/Atelier Atelier"
    "file:///home/${username}/Downloads Downloads"
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };

  home.stateVersion = "25.05";
}
