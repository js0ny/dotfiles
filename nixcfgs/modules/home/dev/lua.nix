{ pkgs, ... }:
{
  home.packages = with pkgs; [
    luajit
    lua-language-server
    stylua
  ];
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
    sumneko.lua
  ];
  programs.zed-editor.extensions = [ "lua" ];
}
