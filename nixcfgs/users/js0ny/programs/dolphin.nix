{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs.kdePackages; [
    dolphin
    dolphin-plugins # dolphin git integration
    konsole # dolphin terminal integration
  ];
  xdg.configFile."dolphinrc-override".text = lib.generators.toINI {} {
    General = {
      ShowSelectionToggle = false;
      UseTabForSwitchingSplitView = true;
    };
    VersionControl = {
      enabledPlugins = "Subversion,Git";
    };
  };

  # Manually merge dolphin config to existing file
  home.activation.mergeDolphinrc = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f ~/.config/dolphinrc-override ]; then
      # Create dolphinrc if it doesn't exist
      touch ~/.config/dolphinrc

      # Merge the override file into the main config
      ${pkgs.crudini}/bin/crudini --merge ~/.config/dolphinrc < ~/.config/dolphinrc-override

      $DRY_RUN_CMD rm -f ~/.config/dolphinrc-override
    fi
  '';
}
