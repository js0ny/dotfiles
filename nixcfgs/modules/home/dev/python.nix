{pkgs, ...}: {
  home.packages = with pkgs; [
    uv
    ruff
  ];
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    ms-python.python
    ms-python.debugpy
    ms-python.vscode-pylance
    charliermarsh.ruff
    njpwerner.autodocstring
  ];
}
