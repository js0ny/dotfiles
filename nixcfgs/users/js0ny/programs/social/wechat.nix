{
  config,
  pkgs,
  ...
}: {
  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/.sandbox/.per-app/wechat 0755 ${config.home.username} users -"
  ];
  home.packages = with pkgs; [
    wechat-uos-sandboxed
  ];
}
