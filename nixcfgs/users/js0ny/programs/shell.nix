{ pkgs, ... }:
let
  commonAliases = {
    v = "nvim";
    g = "lazygit";
    ni = "touch";
    cls = "clear";
    ii = "open";
    c = "code";
    aic = "aichat -s";
  };
in
{
  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
    # preferAbbrs = true;
    shellAbbrs = commonAliases;
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    dotDir = "/home/js0ny/.config/zsh";
    shellAliases = commonAliases;
  };
  programs.bash = {
    enable = true;
    shellAliases = commonAliases;
  };
  programs.zed-editor.extensions = [ "fish" ];
}
