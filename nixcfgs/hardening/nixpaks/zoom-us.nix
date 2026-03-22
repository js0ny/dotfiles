# FIXME: Cursor & CEF not working.
{
  lib,
  pkgs,
  mkNixPak,
  buildEnv,
  makeDesktopItem,
  ...
}: let
  appId = "us.zoom.Zoom";

  wrapped = mkNixPak {
    config = {sloth, ...}: {
      app = {
        package = buildEnv {
          name = "nixpak-zoom";
          paths = with pkgs; [
            zoom-us
          ];
        };
        binPath = "bin/zoom";
      };
      flatpak.appId = appId;

      imports = [
        ./modules/gui-base.nix
        ./modules/network.nix
        ./modules/common.nix
      ];

      bubblewrap = {
        bind.rw = [
          [
            (sloth.concat' sloth.homeDir "/.sandbox/downloads")
            sloth.xdgDownloadDir
          ]
          [
            (sloth.concat' sloth.homeDir "/.sandbox/exchange")
            (sloth.concat' sloth.homeDir "/Shared")
          ]
          (sloth.concat' sloth.homeDir "/Public")
        ];
        bind.ro = [
        ];
        sockets = {
          x11 = false;
          wayland = true;
          pipewire = true;
        };
        env = {
          # LD_LIBRARY_PATH =
        };
      };
    };
  };
  exePath = lib.getExe wrapped.config.script;
in
  buildEnv {
    inherit (wrapped.config.script) name meta passthru;
    paths = [
      wrapped.config.script
      (makeDesktopItem {
        name = appId;
        desktopName = "Zoom Workplace";
        genericName = "Zoom Video Conference";
        comment = "Zoom Video Conference";
        exec = "${exePath} %U";
        terminal = false;
        icon = "${pkgs.zoom-us}/share/pixmaps/Zoom.png";
        startupNotify = true;
        startupWMClass = "zoom";
        type = "Application";
        categories = [
          "Network"
          "Application"
        ];
        mimeTypes = [
          "x-scheme-handler/zoommtg"
          "x-scheme-handler/zoomus"
          "x-scheme-handler/tel"
          "x-scheme-handler/callto"
          "x-scheme-handler/zoomphonecall"
          "x-scheme-handler/zoomphonesms"
          "x-scheme-handler/zoomcontactcentercall"
          "application/x-zoom"
        ];
        extraConfig = {
          X-Flatpak = appId;
          X-KDE-Protocols = "zoommtg;zoomus;tel;callto;zoomphonecall;zoomphonesms;zoomcontactcentercall;";
        };
      })
    ];
  }
