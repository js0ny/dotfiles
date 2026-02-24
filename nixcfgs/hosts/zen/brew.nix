{...}: {
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
      # Productivity
      "obsidian"
      "raycast"
      "TickTick"

      # Networking
      "wireshark-app"
      "clash-verge-rev"
      "protonvpn"
      "openvpn-connect"

      # Terminal Emulator

      # Fonts
      "font-maple-mono-nf-cn"

      # Misc
      "telegram-desktop"
      "cherry-studio" # LLM Client
      "steam"
      "discord"
      "orbstack" # Docker runtime
      "proton-drive"

      # System Enhancement
      "alt-tab" # Turn cmd-tab to windows behaviour
      "karabiner-elements" # Keymapping
      "localsend"
      "squirrel-app" # Input Method
      "rustdesk" # Remote Desktop
      "iina" # MPV Frontend
      # TODO: I think karabiner is the superset
      "scroll-reverser" # Natural scrolling for trackpad only
      "sioyek" # Keyboard-driven PDF Reader
      "skim" # PDF Reader
      "keka" # GUI Unarchiver
      "betterdisplay"

      # Quicklook addons
      "apparency"
      "qlcolorcode"
      "qlmarkdown"
      "qlstephen"
      "qlvideo"
      "qspace-pro"
      "quicklook-json"
      "quicklookase"
    ];
  };
}
