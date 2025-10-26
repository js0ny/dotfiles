{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    go
    gopls
  ];
  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
  };
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    golang.go
  ];
}
