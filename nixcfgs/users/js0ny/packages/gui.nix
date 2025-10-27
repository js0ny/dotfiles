{pkgs, ...}: {
  home.packages = with pkgs; [
    # Terminal Emulator
    ghostty # default
    kitty
    alacritty
    warp-terminal

    # Explorer
    kdePackages.dolphin
    kdePackages.dolphin-plugins # dolphin git integration
    kdePackages.konsole # dolphin terminal integration
    yazi # terminal file manager

    # PDF Viewer
    kdePackages.okular # default
    sioyek

    # Image Viewer
    vimiv-qt # Default
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
    libreoffice
    vivaldi

    # Email
    protonmail-bridge
    thunderbird
    birdtray
  ];

  services.protonmail-bridge.enable = true;

  xdg.desktopEntries = {
    # Force wayland when running goldendict-ng
    "io.github.xiaoyifang.goldendict_ng" = {
      name = "GoldenDict-ng";
      genericName = "Multiformat Dictionary";
      comment = "A feature-rich dictionary lookup program";
      icon = "goldendict";
      type = "Application";
      terminal = false;
      categories = [
        "Office"
        "Dictionary"
        "Education"
        "Qt"
      ];
      mimeType = [
        "x-scheme-handler/goldendict"
        "x-scheme-handler/dict"
      ];
      exec = "env GOLDENDICT_FORCE_WAYLAND=1 ${pkgs.goldendict-ng}/bin/goldendict %u";
      settings = {
        "GenericName[zh_CN]" = "多格式字典";
        "Comment[zh_CN]" = "多功能字典查询软件";
        "Keywords" = "dict;dictionary";
        "Keywords[zh_CN]" = "dict;dictionary;字典;";
        "StartupWMClass" = "GoldenDict-ng";
      };
    };
  };
}
