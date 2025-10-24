{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-wayland-ime"
      "--enable-features=WaylandWindowDecorations"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform-hint=auto"
    ];
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # proton pass
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "gfbliohnnapiefjpjlpjnehglfpaknnc"; } # surfingkeys
      { id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh"; } # immersive translate
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # tampermonkey
    ];
  };
}
