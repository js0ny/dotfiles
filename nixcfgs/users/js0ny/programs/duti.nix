{
  pkgs,
  lib,
  ...
}: let
  gvim = "com.neovide.neovide";
  iina = "com.colliderli.iina";
  # firefox = "org.nixos.firefox";
  keka = "com.aone.keka";

  defaultApps = {
    "${gvim}" = ["md" "json" "js" "txt" "xml"];
    "${iina}" = ["mp4" "mkv"];
    # "${firefox}" = ["html"];
    "${keka}" = ["7z" "zip" "rar" "tar"];
  };

  duti = "${pkgs.duti}/bin/duti";
  mkDutiCommands = app: extensions:
    map (ext: "${duti} -s ${app} ${ext} all") extensions;
in {
  home.packages = [pkgs.duti];

  home.activation.setOSXDefaultApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ${
      lib.concatStringsSep "\n" (
        lib.flatten (lib.mapAttrsToList mkDutiCommands defaultApps)
      )
    }
  '';
}
