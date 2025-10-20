{pkgs, ...}: {
  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
  };
}
