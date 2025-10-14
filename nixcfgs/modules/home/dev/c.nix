{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    llvmPackages_21.clang-tools
  ];
}
