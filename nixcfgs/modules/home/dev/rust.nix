{pkgs, ...}: {
  home.packages = with pkgs; [
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    make
    cmake
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
  ];
}
