{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.picard];

  xdg.configFile."MusicBrainz/Picard-Override.ini".text = lib.generators.toINI {} {
    setting = {
      file_save_warning = false;
      move_files = true;
      rename_files = true;
      show_new_user_dialog = false;
    };
  };

  # Manually merge config
  home.activation.mergePicardIni = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ -f ~/.config/MusicBrainz/Picard-Override.ini ]; then
      # Create Picard.ini if it doesn't exist
      touch ~/.config/MusicBrainz/Picard.ini

      # Merge the override file into the main config
      ${pkgs.crudini}/bin/crudini --merge ~/.config/MusicBrainz/Picard.ini < ~/.config/MusicBrainz/Picard-Override.ini

      $DRY_RUN_CMD rm -f ~/.config/MusicBrainz/Picard-Override.ini
    fi
  '';
}
