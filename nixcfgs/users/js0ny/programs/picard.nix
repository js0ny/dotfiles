{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.picard];

  # see: https://www.navidrome.org/docs/usage/library/tagging/#picard-specific-tips
  xdg.configFile."MusicBrainz/Picard-Override.ini".text = lib.generators.toINI {} {
    setting = {
      check_for_plugin_updates = false;
      check_for_updates = true;
      file_save_warning = false;
      move_files = true;
      move_files_to = "${config.home.homeDirectory}/Music";
      rename_files = true;
      show_new_user_dialog = false;
      cover_image_filename = "cover";
      local_cover_regex = ''^(?:cover|folder|albumart)(.*)\\.(?:jpe?g|png|gif|tiff?|webp)$'';
      windows_compatibility = true;
      windows_long_paths = false;
      preferred_release_countries = "DE, CN, TW, HK";

      ui_language = "zh_CN";
      ui_theme = "system";

      toolbar_layout = "add_directory_action, add_files_action, play_file_action, separator, cluster_action, separator, autotag_action, analyze_action, browser_lookup_action, separator, save_action, view_info_action, remove_action, separator, cd_lookup_action, separator, submit_acoustid_action";
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
