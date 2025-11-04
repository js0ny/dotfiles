# https://github.com/gmodena/nix-flatpak
{...}: {
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
    "com.discordapp.Discord"
    "com.spotify.Client"
    "com.google.EarthPro"
    "com.wps.Office"
    "md.obsidian.Obsidian"
    # "app.zen_browser.zen"
    # "com.vivaldi.Vivaldi"
    "com.getpostman.Postman"
    "us.zoom.Zoom"
    "com.ticktick.Ticktick"
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
    "com.getpostman.Postman".Context.persistent = ["Postman"];
  };
}
