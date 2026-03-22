{
  pkgs,
  lib,
  config,
  ...
}: let
  mergetools = import ../../../../../modules/lib/mergetools.nix {inherit pkgs lib config;};
  mkMergedJson = mergetools.mkMergedJson;
  mkMergedIni = mergetools.mkMergedIni;
  pdxrel = "${config.home.homeDirectory}/.local/share/Paradox Interactive";
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
    target = "${config.home.homeDirectory}/PDX/SDK/victoria3/account.json";
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
    target = "${config.home.homeDirectory}/PDX/SDK/victoria3/telemetry_consent.json";
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
  cleanerPdxSaveData = name: path: {
    inherit path;
    olderThan = 30;
    filesOnly = false;
    recursive = false;
    onCalendar = "weekly";
  };
  pdxSaveDataPaths = {
    ck3 = "${pdxrel}/Crusader Kings III/save games/";
    eu4 = "${pdxrel}/Europa Universalis IV/save games/";
    hoi4 = "${pdxrel}/Hearts of Iron IV/save games/";
    vicky3 = "${pdxrel}/Victoria 3/save games/";
    eu5 = "${euvbase}/save games/";
  };
in {
  imports = [
    ../../lib-cleaner.nix
    paradoxLauncherUserSettings
    victoria3Settings
    pdxSdkSettingsEU5
    pdxSdkSettingsV3
    pdxSdkTelemetryEU5
    pdxSdkTelemetryV3
  ];
  xdg.dataFile = {
    "Paradox Interactive/launcherpath".text = ''
      ${config.home.homeDirectory}/.local/share/paradoxlauncher
    '';
  };
  my.cleanup.jobs = {
    vicky3-crash-reports = {
      path = "${config.home.homeDirectory}/.local/share/Paradox Interactive/Victoria 3/crashes/";
      olderThan = 7;
      filesOnly = false;
      recursive = false;
      onCalendar = "weekly";
    };
    ck3-save-data = cleanerPdxSaveData "ck3" pdxSaveDataPaths.ck3;
    eu4-save-data = cleanerPdxSaveData "eu4" pdxSaveDataPaths.eu4;
    hoi4-save-data = cleanerPdxSaveData "hoi4" pdxSaveDataPaths.hoi4;
    vicky3-save-data = cleanerPdxSaveData "vicky3" pdxSaveDataPaths.vicky3;
    eu5-save-data = cleanerPdxSaveData "eu5" pdxSaveDataPaths.eu5;
  };
}
