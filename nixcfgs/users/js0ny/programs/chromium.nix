{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-wayland-ime"
    ];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # proton pass
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "gfbliohnnapiefjpjlpjnehglfpaknnc";} # surfingkeys
      {id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh";} # immersive translate
    ];
  };
}
