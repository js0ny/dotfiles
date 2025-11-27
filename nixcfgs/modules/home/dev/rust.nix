{pkgs, ...}: {
  home.packages = with pkgs; [
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    gnumake
    cmake
    llvm
    gcc
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    rust-lang.rust-analyzer
  ];
}
