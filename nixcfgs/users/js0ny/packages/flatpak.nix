# https://github.com/gmodena/nix-flatpak
{
  config,
  lib,
  pkgs,
  ...
}: let
  electronApps = [
    "com.getpostman.Postman"
    # "com.ticktick.TickTick"
  ];

  waylandFlags = "\${NIXOS_OZONE_WL:+\${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}";

  appWrappers = lib.listToAttrs (map (appid: {
      name = "flatpak/exports/bin/${appid}";
      value = {
        text = ''
          #!/bin/sh
          exec flatpak run ${appid} ${waylandFlags} "$@"
        '';
        executable = true;
        force = true;
      };
    })
    electronApps);
in {
  services.flatpak.enable = true;
  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];
  services.flatpak.packages = [
    # { appId = "com.google.Chrome"; origin = "flathub" }
    # "com.google.Chrome"
    # "com.valvesoftware.Steam"
    "com.qq.QQ"
    "com.tencent.WeChat"
    # "eu.betterbird.Betterbird"
    # "com.baidu.NetDisk"
    # "com.discordapp.Discord"
    "com.google.EarthPro"
    "com.wps.Office"
    # "md.obsidian.Obsidian"
    # "app.zen_browser.zen"
    # "com.vivaldi.Vivaldi"
    "com.getpostman.Postman"
    "us.zoom.Zoom"
    # "com.ticktick.TickTick" # cannot run on wayland under flatpak
  ];
  services.flatpak.overrides = {
    global = {
      Context = {
        filesystems = [
          "/run/current-system/sw/share/fonts:ro"
          "xdg-config/fontconfig:ro"
          # If user font is set, it is required to access /nix/store
          # since flatpak apps cannot read ~/.config/fontconfig/conf.d/*
          # TODO: This is a bad practice, trying to look for a better solution
          "/nix/store:ro"
          "xdg-data/fonts:ro"
        ];
      };
    };
    "com.qq.QQ".Context.sockets = ["x11"];
    "com.tencent.WeChat" = {
      Context.sockets = ["x11"];
      Environment = {
        # WeChat does not support wayland & wayland-ime
        QT_IM_MODULE = "fcitx";
      };
    };
    "md.obsidian.Obsidian".Context.sockets = ["wayland"];
    "com.ticktick.Ticktick".Context.sockets = ["wayland"];
    "com.getpostman.Postman".Context = {
      persistent = ["Postman"]; # Don't create `~/Postman` folder under home
      sockets = ["wayland"];
    };
  };
  # xdg.dataFile = appWrappers;
  xdg.dataFile =
    {
      # Patch for Hyprland (scale XWayland by hand)
      "flatpak/exports/bin/com.qq.QQ" = {
        text = ''
          #!/bin/sh

          EXTRA_APP_ARGS=""

          if [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
              EXTRA_APP_ARGS="--force-device-scale-factor=1.5"
          fi

          exec flatpak run --branch=stable --arch=x86_64 com.qq.QQ "$EXTRA_APP_ARGS" "$@"
        '';
        enable = true;
        executable = true;
      };
      "flatpak/exports/share/applications/com.qq.QQ.desktop" = {
        text = ''
          [Desktop Entry]
          Name=QQ
          Exec=${config.xdg.dataHome}/flatpak/exports/bin/com.qq.QQ
          Terminal=false
          Type=Application
          Icon=com.qq.QQ
          StartupWMClass=QQ
          Categories=Network;
          Comment=QQ
          X-Flatpak=com.qq.QQ
        '';
        enable = true;
        force = true;
      };
    }
    // appWrappers;
  home.activation.patchFlatpakDesktopFiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${lib.concatMapStringsSep "\n" (appid: ''
        DESKTOP_FILE="${config.xdg.dataHome}/flatpak/exports/share/applications/${appid}.desktop"
        if [ -f "$DESKTOP_FILE" ]; then
          $DRY_RUN_CMD ${pkgs.gnused}/bin/sed -i "s|^\(Exec=.*${appid}\)|\\1 ${waylandFlags}|g" "$DESKTOP_FILE"
        fi
      '')
      electronApps}
  '';
}
