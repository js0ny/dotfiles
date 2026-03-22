{
  pkgs,
  config,
  lib,
  ...
}: let
  noname = pkgs.callPackage ../../../pkgs/noname/default.nix {};
  mergetools = import ../../../modules/lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  mkMergedIni = mergetools.mkMergedIni;
  prismLauncherCfg = mkMergedIni {
    name = "prism-launcher-config";
    target = "${config.home.homeDirectory}/.local/share/PrismLauncher/prismlauncher.cfg";
    settings = {
      General = {
        Language = "zh";
        ApplicationTheme = "Adwaita-Dark";
        ShowConsoleOnError = true;

        PermGen = 128;
        MinMemAlloc = 512;
        MaxMemAlloc = 4096;

        ShowGlobalGameTime = true;
        RecordGameTime = true;
        ShowGameTime = true;
        ShowGameTimeWithoutDays = true;
      };
    };
  };
  ryujinxConfig = mkMergedJson {
    name = "ryujinx-config";
    target = "${config.home.homeDirectory}/.config/Ryujinx/Config.json";
    settings = {
      game_dir = [
        "${config.home.homeDirectory}/Games/ROM/Nintendo - Nintendo Switch"
      ];
      "language_code" = "zh_CN";
      "check_updates_on_start" = false;
    };
  };
in {
  home.packages = with pkgs; [
    steam
    # Steam Adwaita Theme
    adwsteamgtk
    # All-in-one Steam and Proton Tools
    steamtinkerlaunch
    # Mimecraft launcher
    prismlauncher
    # Nintendo Switch Emulator
    ryubing
    # WiiU Emulator
    cemu
    # Game launcher and library manager
    lutris
    # Steam Achievement Manager
    samira

    # Memory Scanner (Cheat Engine Alt.)
    scanmem

    noname

    steamcmd
  ];
  imports = [
    ../programs/gaming/retroarch.nix
    ../programs/gaming/celeste
    ../programs/gaming/PDS
    prismLauncherCfg
    ryujinxConfig
  ];
}
