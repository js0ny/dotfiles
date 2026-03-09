{...}: {
  imports = [
    ./lib.nix
  ];
  programs.celeste = {
    enable = true;
    withSteam = true;
    withOlympus = true;
    settingsFile = ./settings.celeste;
  };
}
