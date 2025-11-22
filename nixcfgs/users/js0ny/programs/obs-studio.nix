{
  pkgs,
  lib,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      input-overlay
      wlrobs
    ];
  };

  xdg.configFile."obs-studio/user.override.ini".text = lib.generators.toINI {} {
    Appearance = {
      Theme = "com.obsproject.Catppuccin.Mocha";
    };
  };

  # Manually merge obs-studio config to existing file
  home.activation.mergeObsStudioConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f ~/.config/obs-studio/user.override.ini ]; then
      # Create gwenviewrc if it doesn't exist
      touch ~/.config/obs-studio/user.ini

      # Merge the override file into the main config
      ${pkgs.crudini}/bin/crudini --merge ~/.config/obs-studio/user.ini < ~/.config/obs-studio/user.override.ini

      $DRY_RUN_CMD rm -f ~/.config/obs-studio/user.override.ini
    fi
  '';
}
