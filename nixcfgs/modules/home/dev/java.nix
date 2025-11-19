{pkgs, ...}: {
  home.packages = with pkgs; [
    jdt-language-server
    jdk21
  ];
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    redhat.java
    vscjava.vscode-spring-initializr
    vscjava.vscode-java-pack
  ];
  programs.zed-editor = {
    extensions = ["java"];
    extraPackages = with pkgs; [
      jdt-language-server
    ];
  };
}
