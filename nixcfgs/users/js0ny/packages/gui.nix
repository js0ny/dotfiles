{
  pkgs,
  lib,
  ...
}: let
  # FIXME: This will block the desktop files
  mkFcitxIM = builtins.map (
    p:
      lib.hiPrio (
        pkgs.runCommand "${p.name}-wrapped" {nativeBuildInputs = with pkgs; [makeWrapper];} ''
          mkdir -p $out/bin
          ln -s ${p}/share $out/share
          makeWrapper \
            ${p}/bin/${p.meta.mainProgram or p.pname} \
            $out/bin/${p.meta.mainProgram or p.pname} \
            --set GTK_IM_MODULE fcitx \
            --set QT_IM_MODULE fcitx
        ''
      )
  );
  # Wrap Electron apps to use Wayland when NIXOS_OZONE_WL is set
  # This only works for apps that does not patched by upstream
  mkElectronWayland = builtins.map (
    p:
      lib.hiPrio (
        pkgs.runCommand "${p.name}-wrapped"
        {
          nativeBuildInputs = [pkgs.makeWrapper];
          meta = p.meta;
        }
        ''
          mkdir -p $out/bin
          ln -s ${p}/share $out/share
          makeWrapper ${lib.getExe p} $out/bin/${p.meta.mainProgram or p.pname} \
            --inherit-argv0 \
            --run '
              if [ -n "$NIXOS_OZONE_WL" ] && [ -n "$WAYLAND_DISPLAY" ]; then
                NIX_WAYLAND_FLAGS="--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true"
              fi
            ' \
            --add-flags "\$NIX_WAYLAND_FLAGS"
        ''
      )
  );
in {
  home.packages = with pkgs;
    [
      # Terminal Emulator
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
      rustdesk
      remmina
      kdePackages.breeze
      zotero
      feishin
      bruno
      bruno-cli
      kicad
      blender
      logisim-evolution
      onlyoffice-desktopeditors
      wayland-bongocat
      kdePackages.qttools
      antigravity
      nur.repos.forkprince.helium-nightly
      prismlauncher
      obsidian
    ]
    ++ (mkFcitxIM [
      pkgs.neovim-qt
    ])
    ++ (mkElectronWayland [
      # pkgs.ticktick
      pkgs.cider-2
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

  # TODO: This is a workaround since upstram did not implement p.name for ticktick
  # xdg.desktopEntries."ticktick" = {
  #   name = "TickTick";
  #   exec = "${lib.getExe pkgs.ticktick} %U";
  #   terminal = false;
  #   type = "Application";
  #   icon = "ticktick";
  #   categories = ["Office"];
  #   comment = "TickTick is a powerful to-do & task management app with seamless cloud synchronization across all your devices. Whether you need to schedule an agenda, make memos, share shopping lists, collaborate in a team, or even develop a new habit, TickTick is always here to help you get stuff done and keep life on track.";
  #   settings = {
  #     StartupWMClass = "TickTick";
  #   };
  # };

  services.protonmail-bridge.enable = true;
  services.remmina.enable = true;
}
