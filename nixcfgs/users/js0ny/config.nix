{pkgs, ...}: {
  my = {
    desktop = {
      preferredApps = {
        shell = pkgs.zsh;
        interactiveShell = pkgs.fish;
        terminal = {
          package = pkgs.kitty;
          execArg = "-e";
        };
      };
    };
  };
}
