{
  config,
  lib,
  ...
}: {
  # Dependency: plasma-manager
  # Required by dolphin's terminal integration
  programs.konsole = {
    enable = true;
    defaultProfile = "Default";
    profiles = {
      Default = {
        command = lib.getExe config.my.desktop.preferredApps.interactiveShell;
        colorScheme = "catppuccin-mocha";
        font = {
          name = "Maple Mono NF CN";
          size = 12;
        };
      };
    };
  };
}
