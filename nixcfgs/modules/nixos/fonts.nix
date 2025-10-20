{
  pkgs,
  config,
  ...
}: let
  fontPkgs = [
    pkgs.maple-mono.NF
    pkgs.sarasa-gothic
    pkgs.lxgw-wenkai
    pkgs.lxgw-neoxihei
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.nerd-fonts.jetbrains-mono
  ];
in {
  environment.systemPackages = fontPkgs;

  fonts = {
    enableDefaultPackages = true;
    packages = fontPkgs;

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [
          "Maple Mono NF"
          "JetBrainsMono Nerd Font"
        ];
        serif = ["LXGW WenKai"];
        sansSerif = ["LXGW Neo XiHei"];
      };
    };
    fontDir.enable = true;
  };

  system.fsPackages = [pkgs.bindfs];
  fileSystems = let
    mkRoSymBind = path: {
      device = path;
      fsType = "fuse.bindfs";
      options = [
        "ro"
        "resolve-symlinks"
        "x-gvfs-hide"
      ];
    };
    aggregated = pkgs.buildEnv {
      name = "system-fonts-and-icons";
      paths =
        fontPkgs
        ++ [
          # Add cursor supports
          pkgs.libsForQt5.breeze-qt5
        ]; # with pkgs; [
      #   libsForQt5.breeze-qt5

      #   noto-fonts
      #   noto-fonts-emoji
      #   noto-fonts-cjk-sans
      #   noto-fonts-cjk-serif
      # ];
      pathsToLink = [
        "/share/fonts"
        "/share/icons"
      ];
    };
  in {
    "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
  };
}
