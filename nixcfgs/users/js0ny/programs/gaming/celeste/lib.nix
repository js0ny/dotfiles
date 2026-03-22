{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.celeste;
in {
  options.programs.celeste = {
    enable = mkEnableOption "Celeste";

    withOlympus = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to include the Olympus mod manager.";
    };

    withSteam = mkOption {
      type = types.bool;
      default = true;
      description = "Whether the game is installed via Steam (affects mod manager configuration).";
    };

    withEverest = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to install Everest mod loader.
        Only applicable when using the celestegame (itch.io) package.
      '';
    };

    writableDir = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Writable directory for Everest mods and logs.
        Required when using celestegame with Everest, since the Nix store is read-only.
        Example: "/home/user/Games/Celeste/writable"
      '';
    };

    gameDir = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = ''
        Path where a symbolic link to the Celeste installation will be created.
        Useful for Olympus to discover the celestegame installation.
        Example: "/home/user/Games/Celeste/game"
      '';
    };

    settingsFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        Path to the Celeste settings XML file in the dotfiles repository.
        Will be symlinked to ~/.local/share/Celeste/Backups/settings.celeste
        via mkOutOfStoreSymlink (out-of-store so the file remains mutable).
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      # Olympus mod manager
      (optional cfg.withOlympus (
        if cfg.withSteam
        then pkgs.olympus.override {celesteWrapper = "steam-run";}
        else
          (
            if cfg.gameDir != null
            then pkgs.olympus.override {finderHints = cfg.gameDir;}
            else pkgs.olympus
          )
      ))
      # celestegame (itch.io DRM-free version)
      ++ (optional (!cfg.withSteam) (
        pkgs.celestegame.override (
          {}
          // (optionalAttrs cfg.withEverest {withEverest = true;})
          // (optionalAttrs (cfg.writableDir != null) {writableDir = cfg.writableDir;})
          // (optionalAttrs (cfg.gameDir != null) {gameDir = cfg.gameDir;})
        )
      ));

    # Symlink settings.celeste from dotfiles repo
    home.file = mkIf (cfg.settingsFile != null) {
      ".local/share/Celeste/Backups/settings.celeste".source =
        config.lib.file.mkOutOfStoreSymlink cfg.settingsFile;
    };
  };
}
