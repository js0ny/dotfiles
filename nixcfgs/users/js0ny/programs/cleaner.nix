{config, ...}: {
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
  };
}
