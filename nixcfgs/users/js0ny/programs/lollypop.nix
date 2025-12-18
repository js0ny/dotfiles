{
  pkgs,
  config,
  ...
}: let
  username = config.home.username;
in {
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
