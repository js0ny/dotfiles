# https://github.com/gmodena/nix-flatpak
{...}: {
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
  ];
  services.flatpak.overrides = {
    "com.tencent.WeChat" = {
      Environment = {
        QT_IM_MODULE = "fcitx";
      };
    };
  };
}
