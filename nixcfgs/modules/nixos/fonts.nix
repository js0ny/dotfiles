{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    maple-mono.NF
    sarasa-gothic
    lxgw-wenkai
    lxgw-neoxihei
    noto-fonts-cjk-sans
    noto-fonts
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  fonts = {
    enableDefaultPackages = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Maple Mono NF" "JetBrainsMono Nerd Font"];
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
      options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
    };
    aggregated = pkgs.buildEnv {
      name = "system-fonts-and-icons";
      paths = with pkgs; [
        libsForQt5.breeze-qt5

        noto-fonts
        noto-fonts-emoji
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
      ];
      pathsToLink = ["/share/fonts" "/share/icons"];
    };
  in {
    # Create an FHS mount to support flatpak host icons/fonts
    "/usr/share/icons" = mkRoSymBind "${aggregated}/share/icons";
    "/usr/share/fonts" = mkRoSymBind "${aggregated}/share/fonts";
  };
}
