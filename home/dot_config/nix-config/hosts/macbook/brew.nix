{ config, pkgs, ...}:

{
  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    taps = [
      "daipeihust/tap"
      "felixkratz/formulae"
      "koekeishiya/formulae"
      "nikitabobko/tap"
      "railwaycat/emacsmacport"
      "js0ny/tap"
    ];

    brews = [
      "folderify"
      "coreutils"
    ];

    casks = [
      "visual-studio-code"
      "kitty"
      "vivaldi"
      "neovide"
      "clash-verge-rev"
      "obsidian"
      "mullvad-vpn"
      "alacritty"
      "alt-tab"
      "apparency"
      "betterdisplay"
      "discord"
      "dotnet-sdk"
      "iina"
      "iterm2"
      "karabiner-elements"
      "keka"
      "localsend"
      "ltspice"
      "orbstack"
      "qlcolorcode"
      # "qlimagesize" discontinued. 
      "qlmarkdown"
      "qlstephen"
      "qlvideo"
      "qspace-pro"
      "quicklook-json"
      "quicklookase"
      "raycast"
      "rider"
      "rustdesk"
      "scroll-reverser"
      "sioyek"
      "skim"
      "squirrel"
      "steam"
      "telegram-desktop"
      "Filen"
      "TickTick"
      "cherry-studio"
      "firefox"
      "Wireshark"
      "LibreWolf"
      "brave-browser"
      "font-maple-mono-nf-cn"
    ];
  };

}
