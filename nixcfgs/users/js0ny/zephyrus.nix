{
  pkgs,
  config,
  ...
}: let
  username = config.home.username;
in {
  imports = [
    ./programs/cleaner.nix
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

    # Browsers
    ./programs/browsers/chromium.nix
    ./programs/browsers/firefox

    # Editors
    ./programs/editors/emacs.nix
    ./programs/editors/nvim.nix
    ./programs/editors/neovide.nix
    ./programs/editors/vscode.nix
    ./programs/editors/zed-editor.nix

    # Terminals
    ./programs/terminals/ghostty.nix
    ./programs/terminals/kitty.nix
    ./programs/terminals/tmux.nix

    # Media
    ./programs/media/cider-2
    ./programs/media/celluloid.nix
    ./programs/media/elisa.nix
    ./programs/media/feishin.nix
    ./programs/media/gallery-dl.nix
    ./programs/media/lollypop.nix
    ./programs/media/mpv.nix
    ./programs/media/obs-studio.nix
    ./programs/media/picard.nix

    # Productivity
    ./programs/productivity/anki.nix
    ./programs/productivity/libreoffice.nix
    ./programs/productivity/obsidian
    ./programs/productivity/readest.nix
    ./programs/productivity/sdcv.nix
    ./programs/productivity/sioyek
    ./programs/productivity/thunderbird.nix
    ./programs/productivity/zoom-us.nix

    # Social
    ./programs/social/discord.nix
    ./programs/social/telegram.nix

    # Utilities & misc
    # ./programs/xilinx.nix
    ./programs/mime.nix
    ./programs/rime
    ./programs/fzf.nix
    ./programs/ollama.nix
    ./programs/sops.nix
    ./programs/pdf2zh/container.nix
    ./programs/gwenview.nix
    ./programs/yazi.nix
    ./programs/dolphin.nix
    ./programs/magick.nix
    ./programs/miniserve.nix
    ./programs/retroarch.nix
    ./programs/edit-clipboard.nix
    ./programs/aichat.nix
    ./programs/wine.nix
    ./programs/libvirt.nix
    ./programs/block-desktop-entries.nix
    ./programs/pwa.nix
    ./programs/walker.nix
    ./programs/fsearch.nix
    # ./programs/openclaw.nix
    ./programs/libmagic.nix

    # Desktop Linux
    ./programs/desktop/gnome
    ./programs/desktop/gnome/paperwm.nix
    ./programs/desktop/gnome/copyous.nix
    ./programs/desktop/wayland-wm/niri

    # General Program config
    ../../modules/home/programs/eza.nix
    # ../../modules/home/programs/winboat.nix
    ../../modules/home/programs/lsd.nix
    ../../modules/home/programs/starship.nix
    ../../modules/home/programs/zoxide.nix

    ../../modules/home/dev/c.nix

    # Development setup
    ../../modules/home/dev/nix.nix

    ../../modules/home/linux.nix
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
  xdg.configFile."gtk-3.0/bookmarks".force = true;

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };

  programs.distrobox.enable = true;

  home.stateVersion = "25.05";
}
