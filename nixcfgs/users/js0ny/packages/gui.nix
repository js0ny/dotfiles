{pkgs, ...}: {
  home.packages = with pkgs; [
    # Terminal Emulator
    ghostty # default
    kitty
    alacritty
    warp-terminal

    # PDF Viewer
    kdePackages.okular # default
    sioyek

    # Image Viewer
    loupe # SUPER FAST 有催人跑的感觉 w/ GPU Accel.

    kdePackages.elisa
    mpv
    haruna

    papirus-icon-theme
    pcloud
    telegram-desktop
    steam
    # Use Wayland for Jetbrains
    (jetbrains.idea-ultimate.override {
      vmopts = ''-Dawt.toolkit.name=WLToolkit'';
    })
    (jetbrains.rider.override {
      vmopts = ''-Dawt.toolkit.name=WLToolkit'';
    })
    localsend
    neovide
    cherry-studio
    kdePackages.kdeconnect-kde
    picard
    qutebrowser
    ryubing
    qbittorrent
    protonvpn-gui
    proton-pass
    neovim-qt
    goldendict-ng
    kdePackages.kdenlive
    gimp
    steam-run
    bottles
    lutris
    vivaldi
    rustdesk
    kdePackages.krdc
    kdePackages.breeze
    zotero
    anki-bin
    feishin
    rose-pine-cursor

    # Email
    protonmail-bridge
    thunderbird
    birdtray
  ];

  home.sessionVariables = {
    ANKI_WAYLAND = 1;
    GOLDENDICT_FORCE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
  };

  xdg.desktopEntries = {
    "anki" = {
      name = "Anki";
      genericName = "Flashcards";
      comment = "An intelligent spaced-repetition memory training program";
      icon = "anki";
      type = "Application";
      terminal = false;
      categories = [
        "Education"
        "Languages"
        "KDE"
        "Qt"
      ];
      mimeType = [
        "application/x-apkg"
        "application/x-anki"
        "application/x-ankiaddon"
      ];
      # Should specify wayland and IME used
      exec = "env ANKI_WAYLAND=1 QT_IM_MODULE=fcitx anki %f";
      settings = {
        "TryExec" = "anki";
        "Version" = "1.0";
        "X-GNOME-SingleWindow" = "true";
        "SingleMainWindow" = "true";
        "StartupWMClass" = "anki";
      };
    };
  };

  # TODO: This is a dependency of `feishin` (EOL)
  # Once the new version is published, delete this
  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  services.protonmail-bridge.enable = true;
}
