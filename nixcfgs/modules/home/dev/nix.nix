{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    nixd
  ];
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    kamadorueda.alejandra
    jnoortheen.nix-ide
  ];

  programs.zed-editor.extensions = ["nix"];
}
