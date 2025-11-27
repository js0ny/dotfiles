{
  pkgs,
  config,
  ...
}: {
  home.sessionVariables.ANKI_WAYLAND = 1;
  programs.anki = {
    enable = true;
    addons = with pkgs.ankiAddons; [
      anki-connect
      review-heatmap
      # recolor # Use stylix
    ];
    sync = {
      autoSync = true;
      autoSyncMediaMinutes = 15;
      username = "ankiweb.unusable450@passmail.net";
      keyFile = config.sops.secrets."ANKI_SYNC_KEY".path;
    };
  };
}
