{
  pkgs,
  config,
  lib,
  ...
}: let
  term = lib.getExe config.my.desktop.preferredApps.terminal.package;
  termArg = config.my.desktop.preferredApps.terminal.execArg;
in {
  home.packages = [pkgs.miniserve];
  home.file.".local/share/kio/servicemenus/miniserve.desktop" = {
    enable = true;
    executable = true;
    text = ''
      [Desktop Entry]
      Type=Service
      MimeType=inode/directory
      Actions=miniserveDir
      Icon=network-server
      X-KDE-Priority=TopLevel
      X-KDE-StartupNotify=false

      [Desktop Action miniserveDir]
      Name=Map Directory to Port 8080
      Name[CN]=将目录映射到网上(8080)
      Icon=network-server
      Exec=${term} --title "miniserve" ${termArg} miniserve "%f" --port 8080
    '';
  };
}
