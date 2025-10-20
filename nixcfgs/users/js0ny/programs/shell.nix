{config, ...}: let
  commonAliases = {
    v = "nvim";
    g = "lazygit";
    ni = "touch";
    cls = "clear";
    ii = "open";
    c = "code";
    aic = "aichat -s";
    aicc = "aichat -c";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles/nixcfgs";
  };
in {
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
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = commonAliases;
  };
  programs.bash = {
    enable = true;
    shellAliases = commonAliases;
  };
  programs.zed-editor.extensions = ["fish"];
}
