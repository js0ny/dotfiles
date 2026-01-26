{
  pkgs,
  config,
  ...
}: let
  username = config.home.username;
in {
  # Note: lollypop is buggy with CJK filenames.
  # 部分 CJK 文字会显示成 ??，可能和文件的编码有关？而且似乎是 GTK4 都会，GNOME 全家桶的音乐播放器也有这个问题
  home.packages = with pkgs; [lollypop];
  dconf.settings = {
    "org/gnome/Lollypop" = {
      music-uris = [
        "file:///home/${username}/Music"
      ];
      notification-flag = 2;
    };
  };
}
