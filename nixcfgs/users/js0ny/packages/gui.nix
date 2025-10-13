{ pkgs, ... }:
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
    jetbrains.idea-ultimate
    jetbrains.rider
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
    protonmail-bridge
  ];
}
