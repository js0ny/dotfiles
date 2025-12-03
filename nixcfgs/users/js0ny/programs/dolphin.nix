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
      EnabledPlugins = "Subversion,Git";
    };
  };

  imports = [./konsole.nix];

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

  home.file.".local/share/kio/servicemenus/move-file.desktop" = {
    enable = true;
    executable = true;
    text = ''
      [Desktop Entry]
      Type=Service
      MimeType=all/all
      Actions=to-inbox;to-public
      X-KDE-Submenu=Move file to...
      X-KDE-Submenu[CN]=将文件移动到
      Icon=mail-move

      [Desktop Action to-inbox]
      Name=Inbox
      Icon=inbox
      Exec=mv "%f" $HOME/Inbox/

      [Desktop Action to-public]
      Name=Public
      Icon=document-share
      Exec=mv "%f" $HOME/Public/
    '';
  };
}
