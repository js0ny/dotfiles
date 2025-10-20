{pkgs, ...}: {
  home.packages = with pkgs; [
    go
    gopls
  ];
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    golang.go
  ];
}
