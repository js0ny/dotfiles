{...}: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      # Done by NIXOS_OZONE_WL=1
      # "--enable-wayland-ime"
      # "--enable-features=WaylandWindowDecorations"
      # "--enable-features=UseOzonePlatform"
      # "--ozone-platform-hint=auto"
      # See: https://wiki.archlinux.org/title/Chromium#Touchpad_gestures_for_navigation
      "--enable-features=TouchpadOverscrollHistoryNavigation"
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # proton pass
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "gfbliohnnapiefjpjlpjnehglfpaknnc";} # surfingkeys
      {id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh";} # immersive translate
      {id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";} # tampermonkey
    ];
  };
}
