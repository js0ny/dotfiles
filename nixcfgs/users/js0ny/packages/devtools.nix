{
  pkgs,
  config,
  ...
}: {
  # Globally installed development tools
  home.packages = with pkgs; [
    vscode-json-languageserver
    alejandra
    gnumake
    nil
    jq
    yq-go
    tokei
    socat
    shellcheck
  ];
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GOPATH = "${config.xdg.dataHome}/go";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
  };
  systemd.user.tmpfiles.rules = [
    "d ${config.xdg.dataHome}/cargo 0755 ${config.home.username} users -"
    "d ${config.xdg.dataHome}/go 0755 ${config.home.username} users -"
    "f ${config.xdg.stateHome}/python 0755 ${config.home.username} users -"
  ];
}
