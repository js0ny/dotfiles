{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    llvmPackages_21.clang-tools # clangd
  ];

  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    llvm-vs-code-extensions.vscode-clangd
  ];
}
