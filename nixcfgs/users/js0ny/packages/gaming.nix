{
  pkgs,
  config,
  lib,
  ...
}: let
  mergetools = import ../lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  mkMergedIni = mergetools.mkMergedIni;
  pdxrel = ".local/share/Paradox Interactive";
  # pdxbase = "${config.home.homeDirectory}/${pdxrel}";
  euvbase = "${config.home.homeDirectory}/.local/share/Steam/steamapps/compatdata/3450310/pfx/drive_c/users/steamuser/Documents/Paradox Interactive/Europa Universalis V";
  paradoxLauncherUserSettings = mkMergedJson {
    name = "paradox-launcher-usersettings";
    target = "${pdxrel}/launcher-v2/userSettings.json";
    settings = {
      "optionalTelemetryDisabled" = true;
      "language" = "zh-hans";
    };
  };
  pdxSdkSettingsEU5 = mkMergedJson {
    name = "pdxSdkaccountJsonEU5";
    target = "${euvbase}/PDX/SDK/eu5/account.json";
    settings = {
      telemetryEnabled = false;
    };
  };
  # 经典 $HOME 下拉屎
  pdxSdkSettingsV3 = mkMergedJson {
    name = "pdxSdkaccountJsonV3";
    target = "PDX/SDK/victoria3/account.json";
    settings = {
      telemetryEnabled = false;
    };
  };
  pdxSdkTelemetryEU5 = mkMergedJson {
    name = "pdxSdktelemetryConsentEU5";
    target = "${euvbase}/PDX/SDK/eu5/telemetry_consent.json";
    settings = {
      telemetry_consent_choice = "denied";
    };
  };
  pdxSdkTelemetryV3 = mkMergedJson {
    name = "pdxSdktelemetryConsentV3";
    target = "PDX/SDK/victoria3/telemetry_consent.json";
    settings = {
      telemetry_consent_choice = "denied";
    };
  };
  victoria3Settings = mkMergedJson {
    name = "victoria3-settings";
    target = "${pdxrel}/Victoria 3/pdx_settings.json";
    settings = {
      Account = {
        telemetry_consent = false;
      };
      game = {
        save_on_exit = true;
      };
      Theme = {
        daynight_cycle = false;
      };
    };
  };
  prismLauncherCfg = mkMergedIni {
    name = "prism-launcher-config";
    target = ".local/share/PrismLauncher/prismlauncher.cfg";
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
    target = ".config/Ryujinx/Config.json";
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
  ];
  imports = [
    ../programs/retroarch.nix
    paradoxLauncherUserSettings
    victoria3Settings
    pdxSdkSettingsEU5
    pdxSdkSettingsV3
    pdxSdkTelemetryEU5
    pdxSdkTelemetryV3
    prismLauncherCfg
    ryujinxConfig
  ];
  xdg.dataFile = {
    "Paradox Interactive/launcherpath".text = ''
      ${config.home.homeDirectory}/.local/share/paradoxlauncher
    '';
  };
}
