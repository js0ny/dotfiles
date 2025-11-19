{
  pkgs,
  lib,
  ...
}: let
  mkFcitxIM = builtins.map (
    p:
      lib.hiPrio (
        pkgs.runCommand "${p.name}-wrapped" {nativeBuildInputs = with pkgs; [makeWrapper];} ''
          mkdir -p $out/bin
          makeWrapper \
            ${p}/bin/${p.meta.mainProgram or p.pname} \
            $out/bin/${p.meta.mainProgram or p.pname} \
            --set GTK_IM_MODULE fcitx \
            --set QT_IM_MODULE fcitx
        ''
      )
  );
in {
  home.packages = with pkgs;
    [
      # Terminal Emulator
      ghostty # default
      kitty
      alacritty
      warp-terminal

      # PDF Viewer
      kdePackages.okular # default
      sioyek

      # Image Viewer
      loupe # SUPER FAST 有催人跑的感觉 w/ GPU Accel.

      kdePackages.elisa
      haruna

      # Email
      protonmail-bridge
      thunderbird
      birdtray

      # Theming
      papirus-icon-theme
      rose-pine-cursor

      pcloud
      materialgram
      ayugram-desktop
      steam
      signal-desktop
      # Use Wayland for Jetbrains
      (jetbrains.idea-ultimate.override {
        vmopts = ''-Dawt.toolkit.name=WLToolkit'';
      })
      (jetbrains.rider.override {
        vmopts = ''-Dawt.toolkit.name=WLToolkit'';
      })
      localsend
      cherry-studio
      kdePackages.kdeconnect-kde
      picard
      qutebrowser
      ryubing
      qbittorrent
      protonvpn-gui
      proton-pass
      goldendict-ng
      kdePackages.kdenlive
      gimp
      steam-run
      bottles
      lutris
      rustdesk
      kdePackages.krdc
      kdePackages.breeze
      zotero
      anki-bin
      feishin
      bruno
      bruno-cli
      cider-2
      kicad
      blender
      qmk
      logisim-evolution
    ]
    ++ (mkFcitxIM [
      pkgs.neovim-qt
      pkgs.anki
    ]);

  home.sessionVariables = {
    ANKI_WAYLAND = 1;
    GOLDENDICT_FORCE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
  };

  # TODO: This is a dependency of `feishin` (EOL)
  # Once the new version is published, delete this
  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];

  services.protonmail-bridge.enable = true;
}
