{config, ...}: let
  home = config.home.homeDirectory;
  user = config.home.username;
in {
  systemd.user.tmpfiles.rules = [
    "d ${home}/.sandbox/exchange 0755 ${user} users -"
    "d ${home}/.sandbox/downloads 0755 ${user} users -"
  ];
}
