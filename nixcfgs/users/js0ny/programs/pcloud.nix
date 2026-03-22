{
  pkgs,
  lib,
  ...
}: let
  pcloudAntidots = pkgs.writeShellScriptBin "pcloud-antidots" ''
    set -euo pipefail

    real_home="$HOME"
    fake_home="$real_home/.sandbox/.per-app/pcloud"

    mkdir -p \
      "$fake_home" \
      "$fake_home/.config" \
      "$fake_home/.cache" \
      "$fake_home/.local/share" \
      "$fake_home/.local/state"

    export HOME="$fake_home"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"

    exec ${lib.getExe pkgs.pcloud} "$@"
  '';

  pcloudAntidotsDesktop = pkgs.makeDesktopItem {
    name = "pcloud-antidots";
    desktopName = "pCloud (Antidots)";
    exec = "${lib.getExe pcloudAntidots}";
    terminal = false;
    categories = ["Network" "FileTransfer"];
  };
in {
  home.packages = [
    pkgs.pcloud
    pcloudAntidots
    pcloudAntidotsDesktop
  ];
}
