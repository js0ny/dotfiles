{pkgs, ...}: {
  home.packages = with pkgs; [
    typst
    typstyle
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    myriad-dreamin.tinymist
  ];
}
