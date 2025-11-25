{
  lib,
  pkgs,
  ...
}: let
  # TODO: Implement an allow list feature later
  # allowList = [];
  blockDesktopEntries = pkgs.writeShellApplication {
    name = "block-desktop-entries";

    runtimeInputs = with pkgs; [
      findutils
      crudini
      desktop-file-utils
    ];
    excludeShellChecks = ["SC2016"];
    text = ''
      target="''${1:-}"

      if [ -z "$target" ]; then
        echo "Usage: block-desktop-entries <prefix>"
        echo "Example: block-desktop-entries waydroid"
        exit 1
      fi

      xdg_data="''${XDG_DATA_HOME:-$HOME/.local/share}"
      app_dir="$xdg_data/applications"

      if [ -d "$app_dir" ]; then
        echo "Blocking desktop entries starting with: $target in $app_dir"

        find "$app_dir" -type f -name "$target.*.desktop" -exec crudini --set {} "Desktop Entry" NoDisplay true \;

        update-desktop-database "$app_dir"
      else
        echo "Applications directory not found: $app_dir"
      fi
    '';
  };
in {
  home.packages = [blockDesktopEntries];

  home.activation.blockWaydroidApps = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -n "$VERBOSE_ARG" ]; then
      echo "Running block-desktop-entries for Waydroid..."
    fi

    ${lib.getExe blockDesktopEntries} "waydroid"
  '';
}
