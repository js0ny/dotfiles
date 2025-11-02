{pkgs, ...}: let
  fontPkgs = [
    pkgs.maple-mono.NF-CN
    pkgs.lxgw-wenkai
    pkgs.lxgw-neoxihei
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nur.repos.definfo.sarasa-term-sc-nerd
    pkgs.vollkorn
    pkgs.font-awesome
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
          "Maple Mono NF CN"
          "Sarasa Term SC Nerd"
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
          pkgs.kdePackages.breeze
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
