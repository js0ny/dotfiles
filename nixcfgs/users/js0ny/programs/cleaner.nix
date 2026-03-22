{config, ...}: let
  cleanerPdxSaveData = name: path: {
    inherit path;
    olderThan = 30;
    filesOnly = false;
    recursive = false;
    onCalendar = "weekly";
  };
  pdxrel = "${config.xdg.dataHome}/Paradox Interactive";
  pdxSaveDataPaths = {
    ck3 = "${pdxrel}/Crusader Kings III/save games/";
    eu4 = "${pdxrel}/Europa Universalis IV/save games/";
    hoi4 = "${pdxrel}/Hearts of Iron IV/save games/";
    vicky3 = "${pdxrel}/Victoria 3/save games/";
    eu5 = "${pdxrel}/Europa Universalis V/save games/";
  };
in {
  imports = [
    ./lib-cleaner.nix
  ];
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
  };
}
