# Refer:
# - Flatpak manifest's docs:
#   - https://docs.flatpak.org/en/latest/manifests.html
#   - https://docs.flatpak.org/en/latest/sandbox-permissions.html
# - QQ's flatpak manifest: https://github.com/flathub/com.qq.QQ/blob/master/com.qq.QQ.yaml
{
  lib,
  qq,
  pkgs,
  mkNixPak,
  buildEnv,
  makeDesktopItem,
  ...
}: let
  appId = "com.qq.QQ";

  wrapped = mkNixPak {
    config = {sloth, ...}: {
      app = {
        package = buildEnv {
          name = "nixpak-qq";
          paths = [
            qq
            pkgs.libx11
            pkgs.libxcb
            pkgs.krb5.lib
            pkgs.libgssglue
            pkgs.stdenv.cc.cc.lib
            # pkgs.fcitx5-gtk
            # pkgs.kdePackages.fcitx5-qt
          ];
        };
        binPath = "bin/qq";
      };
      flatpak.appId = appId;

      imports = [
        ./modules/gui-base.nix
        ./modules/network.nix
        ./modules/common.nix
      ];

      bubblewrap = {
        bind.rw = [
          sloth.xdgDocumentsDir
          sloth.xdgDownloadDir
          sloth.xdgMusicDir
          sloth.xdgVideosDir
          sloth.xdgPicturesDir
        ];
        bind.ro = [
          "${pkgs.libx11}/lib"
          "${pkgs.libxcb}/lib"
          "${pkgs.krb5.lib}/lib"
          "${pkgs.stdenv.cc.cc.lib}/lib"
          # "${pkgs.fcitx5-gtk}/lib"
          # "${pkgs.kdePackages.fcitx5-qt}/lib"
          # (sloth.envOr "XAUTHORITY" (sloth.concat' sloth.runtimeDir "/.Xauthority"))
        ];
        sockets = {
          x11 = false;
          wayland = true;
          pipewire = true;
        };
        env = {
          LD_LIBRARY_PATH = "${pkgs.libx11}/lib:${pkgs.libxcb}/lib:${pkgs.krb5.lib}/lib:${pkgs.libgssglue}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.fcitx5-gtk}/lib:${pkgs.kdePackages.fcitx5-qt}/lib";
          # XAUTHORITY = sloth.envOr "XAUTHORITY" (sloth.concat' sloth.runtimeDir "/.Xauthority");
          # QT_QPA_PLATFORM = "xcb";
          # ELECTRON_OZONE_PLATFORM_HINT = "x11";
          # QT_PLUGIN_PATH = "${pkgs.kdePackages.fcitx5-qt}/lib/qt-6/plugins";
          # GTK_PATH = "${pkgs.fcitx5-gtk}/lib/gtk-3.0";
          # GTK_IM_MODULE = "fcitx";
          # QT_IM_MODULE = "fcitx";
          # SDL_IM_MODULE = "fcitx";
          # XMODIFIERS = "@im=fcitx";
          # INPUT_METHOD = "fcitx";
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
        desktopName = "QQ";
        genericName = "QQ Boxed";
        comment = "Tencent QQ, also known as QQ, is an instant messaging software service and web portal developed by the Chinese technology company Tencent.";
        exec = "${exePath} %U";
        terminal = false;
        icon = "${qq}/share/icons/hicolor/512x512/apps/qq.png";
        startupNotify = true;
        startupWMClass = "QQ";
        type = "Application";
        categories = [
          "InstantMessaging"
          "Network"
        ];
        extraConfig = {
          X-Flatpak = appId;
        };
      })
    ];
  }
