{config, ...}: {
  systemd.user.tmpfiles.rules = [
    "d ${config.xdg.dataHome}/gnupg 0700 ${config.home.username} users -"
  ];
}
