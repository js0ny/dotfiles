{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kitty
    ghostty
    alacritty
    kdePackages.dolphin
    kdePackages.okular
    kdePackages.elisa
    papirus-icon-theme
    firefox
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
    warp-terminal
    # clash-verge-rev
    haruna
    sioyek
    vimiv-qt
    imv
    localsend
    neovide
    cherry-studio
    vivaldi
    kdePackages.kdeconnect-kde
    picard
    qutebrowser
    ryubing
    qbittorrent
    protonvpn-gui
    proton-pass
    protonmail-bridge-gui
    mpv
    neovim-qt
    goldendict-ng
  ];

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
