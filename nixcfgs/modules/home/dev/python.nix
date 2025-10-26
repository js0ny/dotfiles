{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    uv
    ruff
  ];
  home.sessionVariables = {
    PYTHON_HISTORY = "${config.xdg.dataHome}/python/history";
  };
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    ms-python.python
    ms-python.debugpy
    ms-python.vscode-pylance
    charliermarsh.ruff
    njpwerner.autodocstring
  ];
}
