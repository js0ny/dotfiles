{pkgs, ...}: {
  home.packages = with pkgs; [
    typst
    typstyle
    tinymist
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    myriad-dreamin.tinymist
  ];

  programs.zed-editor.extensions = ["typst"];
}
